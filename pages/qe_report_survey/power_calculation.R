############################################################
# Power and design analysis for A/B Likert-based PPIE study
# Statistical basis:
# Likert items (5-point) are treated as approximately
# continuous for primary analysis, which is standard in
# high-impact clinical journals when justified and supported
# by sensitivity analyses. The primary estimand is the
# difference in mean Likert score between two independent
# groups. Effect size is defined as Cohen's d = 0.5, which
# corresponds to a 0.5 point shift on a 1–5 scale assuming
# SD ≈ 1.0. Two-sided alpha = 0.05.
############################################################

# Libraries
library(pwr)
library(gsDesign)
library(ggplot2)
library(tidyr)

############################################################
# 1. Core power calculations
############################################################

effect_size <- 0.5   # Cohen's d
alpha <- 0.05

# 80% power
power_80 <- pwr.t.test(
  d = effect_size,
  sig.level = alpha,
  power = 0.8,
  type = "two.sample",
  alternative = "two.sided"
)

# 90% power
power_90 <- pwr.t.test(
  d = effect_size,
  sig.level = alpha,
  power = 0.9,
  type = "two.sample",
  alternative = "two.sided"
)

print(power_80)
print(power_90)

############################################################
# 2. Group sequential design with one interim analysis
# O'Brien–Fleming boundaries
############################################################

gs <- gsDesign(
  k = 2,
  alpha = 0.05,
  beta = 0.2,
  test.type = 2,
  sfu = "OF"
)

print(gs)

############################################################
# 3. Simulation under realistic Likert discretisation
############################################################

set.seed(1)

simulate_trial <- function(n_per_group, shift = 0.5) {
  A <- round(pmin(pmax(rnorm(n_per_group, mean = 3, sd = 1), 1), 5))
  B <- round(pmin(pmax(rnorm(n_per_group, mean = 3 + shift, sd = 1), 1), 5))
  t.test(A, B)$p.value
}

pvals <- replicate(1000, simulate_trial(n_per_group = 64, shift = 0.5))
empirical_power <- mean(pvals < 0.05)
print(empirical_power)

############################################################
# 4. Power curve for varying sample sizes
############################################################

ns <- seq(20, 120, by = 5)

power_df <- data.frame(
  n = ns,
  power = sapply(ns, function(n) {
    pwr.t.test(
      d = effect_size,
      n = n,
      sig.level = alpha,
      type = "two.sample"
    )$power
  })
)

p_power <- ggplot(power_df, aes(x = n, y = power)) +
  geom_line(size = 1) +
  geom_hline(yintercept = 0.8, linetype = "dashed") +
  xlim(0,130) +
  labs(
    x = "Participants per group (total sample = 2 × n)",
    y = "Statistical power",
    subtitle = "Power to detect a 0.5 Likert point difference"
  ) + 
  theme_bw()

p_power

ggsave("../images/p_power_survey.pdf", p_power, width = 4, height = 2.5)

############################################################
# 5. Example simulated outcome distribution
# Always show all datapoints together with summary statistics
############################################################

set.seed(1)

df <- data.frame(
  score = c(
    round(rnorm(64, mean = 3, sd = 1)),
    round(rnorm(64, mean = 3.5, sd = 1))
  ),
  group = rep(c("Test A", "Test B"), each = 64)
)

df$score <- pmin(pmax(df$score, 1), 5)

ggplot(df, aes(x = group, y = score)) +
  geom_boxplot(
    width = 0.4,
    outlier.shape = NA,
    alpha = 0.4
  ) +
  geom_jitter(
    width = 0.12,
    height = 0,
    size = 1.8,
    alpha = 0.7
  ) +
  stat_summary(
    fun = mean,
    geom = "point",
    shape = 23,
    size = 4,
    fill = "white"
  ) +
  scale_y_continuous(breaks = 1:5, limits = c(1, 5)) +
  labs(
    x = "",
    y = "Likert score",
    title = "Simulated distribution of trust scores"
  ) +
  theme_bw() +
  theme(
    legend.position = "none"
  )
