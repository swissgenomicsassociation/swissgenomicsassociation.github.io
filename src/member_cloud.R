
library(tidyverse)
library(tidytext)
library(stringr)
library(httr)
library(jsonlite)
library(purrr)
library(tibble)
library(stm)
library(igraph)
library(tidygraph)
library(ggraph)
library(ggplot2)
library(scales)

# parameters ----
n_users  <- 40
split_by <- "section"
use_basis_corpus <- TRUE
basis_weight <- 0.3 # this is sensitve 
beta_threshold <- 0.01
edge_min_weight <- .9
K <- 8


# K <- 12            # increase topics from 6 to 8 or 10
# # beta_threshold <- 0.005  # lower to allow smaller topic presence to be kept
# edge_min_weight <- 0.75  # reduce so weaker topic co-occurrence edges still form
# basis_weight <- 0.5     # slightly reduce corpus influence to diversify topics


# basis corpus ingestion ----
txt <- read_lines("basic_corpus.txt") |> paste(collapse = "\n")

chunks <- if (split_by == "section") {
  txt |> str_split("\n(?=\\d+\\s[A-Z])") |> unlist()
} else {
  txt |> str_split("\n\n+") |> unlist()
}

corpus_basis <- tibble(section = seq_along(chunks), text = chunks) |>
  mutate(user = paste0("synthetic_user_", (section %% n_users) + 1)) |>
  mutate(text = str_squish(text)) |>
  mutate(id = user, biotext = text) |>
  select(id, biotext)

tokens_basis <- corpus_basis |>
  unnest_tokens(word, biotext)

# fetch real profiles ----
supabase_url <- "https://pjslulmnfxtfihdtzrbu.supabase.co"
supabase_key <- "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBqc2x1bG1uZnh0ZmloZHR6cmJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIyNjEzODUsImV4cCI6MjA3NzgzNzM4NX0.7fPGKu7rbziVGl4X5T2qVoqu0Yt0enR4lisYq3sdnMY"

res <- GET(
  url = paste0(supabase_url, "/rest/v1/profiles"),
  add_headers(
    apikey = supabase_key,
    Authorization = paste("Bearer", supabase_key)
  )
)

df <- res %>%
  httr::content(as = "text", encoding = "UTF-8") %>%
  jsonlite::fromJSON(flatten = TRUE) %>%
  tibble::as_tibble()

clean_text <- function(x) ifelse(is.na(x), "", x)

extract_terms <- function(x) {
  sw <- c("the","and","with","for","over","into","from","work","works","working",
          "within","years","year","based","lead","leads","role","roles",
          "expertise","expert","specialist","senior","junior","focus","focused",
          "include","including","responsible","team")
  
  toks <- x |> 
    tolower() |>
    str_replace_all("[,.;()]", " ") |>
    str_replace_all("[^a-z0-9\\s]", "") |>
    str_split("\\s+") |> 
    unlist()
  
  toks[!toks %in% sw & nchar(toks) > 2] |> unique()
}

df <- df |>
  mutate(
    biotext = clean_text(biotext),
    title   = clean_text(title),
    terms   = map2(biotext, title, ~ unique(c(extract_terms(.x), extract_terms(.y))))
  )

docs_real <- df |>
  select(id, biotext) |>
  mutate(
    biotext = str_replace_all(biotext, "[^a-zA-Z0-9 ]", " "),
    biotext = str_squish(biotext),
    biotext = tolower(biotext)
  )

# merge basis + real ----
docs <- docs_real
if (use_basis_corpus) docs <- bind_rows(docs, corpus_basis)

docs <- docs |>
  mutate(w = if_else(str_starts(id, "synthetic_user_"), basis_weight, 1))

# tokenise + prepare stm documents ----
stop_words_vec <- tidytext::stop_words$word

tokens <- docs |>
  unnest_tokens(word, biotext) |>
  filter(!word %in% stop_words_vec, nchar(word) > 2)

# aggregate counts per doc-word
tokens_counts <- tokens |>
  count(id, word, name = "n")

# apply weighting (round to integer)
tokens_counts <- tokens_counts |>
  left_join(docs |> select(id, w), by = "id") |>
  mutate(n = round(n * w)) |>
  filter(n > 0)

# build vocabulary (sorted) and index mapping
vocab <- tokens_counts %>% distinct(word) %>% arrange(word) %>% pull(word)
word_index <- set_names(seq_along(vocab), vocab)

# create documents list in stm format: each document is a 2 x M matrix (wordindex, count)
docs_list <- tokens_counts %>%
  mutate(word_index = word_index[word]) %>%
  group_by(id) %>%
  summarise(mat = list({
    dfm <- cur_data_all()
    # ensure unique word indices per document (they already are after count)
    widx <- dfm$word_index
    cnt  <- dfm$n
    if (length(widx) == 0) {
      matrix(integer(0), nrow = 2)
    } else {
      m <- rbind(widx, cnt)
      # order by index
      ord <- order(m[1, ])
      m[, ord, drop = FALSE]
    }
  }), .groups = "drop")

# convert to named list with docs in same order as vocab usage
documents <- set_names(map(docs_list$mat, ~ as.matrix(.x)), docs_list$id)

# remove any empty documents
documents <- documents[map_lgl(documents, ~ ncol(.x) > 0)]

# sanity checks: indices within 1:V
V <- length(vocab)
documents <- map(documents, function(mat) {
  if (ncol(mat) == 0) return(mat)
  mat <- matrix(as.integer(mat), nrow = 2)
  # drop any columns with index > V or <=0
  keep <- which(mat[1, ] >= 1 & mat[1, ] <= V)
  if (length(keep) == 0) return(matrix(integer(0), nrow = 2))
  mat[, keep, drop = FALSE]
})

# prepare metadata (optional)
meta <- tibble(doc_id = names(documents))

# run STM ----
stm_out <- stm(
  documents = documents,
  vocab = vocab,
  K = K,
  verbose = FALSE
)

topics <- tidy(stm_out, matrix = "beta") |>
  group_by(topic) |>
  slice_max(beta, n = 10) |>
  ungroup()

# topic network ----
top_terms <- if (beta_threshold > 0) topics |> filter(beta > beta_threshold) else topics

nodes <- top_terms |>
  group_by(term) |>
  summarise(size = sum(beta), .groups = "drop") |>
  arrange(desc(size)) |>
  mutate(name = term) |>
  select(name, size)

edge_list <- top_terms |>
  group_by(topic) |>
  summarise(terms = list(term), .groups = "drop") |>
  mutate(pairs = map(terms, ~ {
    x <- unique(.x)
    if (length(x) < 2) return(tibble(from = character(), to = character()))
    m <- t(combn(sort(x), 2))
    as_tibble(m) |> set_names(c("from", "to"))
  })) |>
  pull(pairs)

edges <- bind_rows(edge_list) |>
  mutate(from = as.character(from), to = as.character(to)) |>
  filter(from %in% nodes$name, to %in% nodes$name) |>
  count(from, to, name = "weight") |>
  filter(weight >= edge_min_weight)

nodes <- nodes |> filter(name %in% unique(c(edges$from, edges$to)))

# clustering ----
ig <- graph_from_data_frame(edges, vertices = nodes, directed = FALSE)

cluster_membership <- if (vcount(ig) > 0 && ecount(ig) > 0) {
  membership(cluster_louvain(ig, weights = E(ig)$weight))
} else {
  setNames(rep(1, vcount(ig)), V(ig)$name)
}

nodes$cluster <- factor(cluster_membership[nodes$name])

g <- tbl_graph(nodes = nodes, edges = edges, directed = FALSE)

# plot ----
node_palette <- c("#2563eb", "#7c3aed", "#db2777", "#059669", "#eab308", "#f97316",
                  "#06b6d4", "#8b5cf6", "#fb7185", "#84cc16")

label_fill <- alpha("white", 0.5)
set.seed(42)

p <- ggraph(g, layout = "stress") +
  geom_edge_link(aes(width = weight), colour = "#cbd5e1", alpha = 0.45, show.legend = FALSE) +
  geom_node_point(aes(size = size, fill = cluster), colour = "navy", stroke = 0.8, shape = 21, show.legend = FALSE) +
  geom_node_label(aes(label = name),
                  repel = TRUE,
                  size = 4.2,
                  label.size = 0.35,
                  fill = label_fill,
                  colour = "#0f172a",
                  show.legend = FALSE) +
  scale_fill_manual(values = node_palette) +
  scale_size(range = c(3, 14)) +
  scale_edge_width(range = c(0.3, 2)) +
  theme(legend.position = "none") +
  theme_void()

print(p)


ggsave("member_cloud.png", p, width = 8, height =5)
