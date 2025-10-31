<!-- --- -->
<!-- title: "AI HPO finder" -->
<!-- date: 2025-06-28T00:00:01+10:00 -->
<!-- weight: 9 -->
<!-- --- -->

### Example terms

* Arachnodactyly, Marfan syndrome, FBN1
* Test: Atrial septal defect, coronary sinus type, Pancreatic and cerebellar agenesis, Down syndrome
    - HP:0001667 = Right ventricular hypertrophy
    - HP:0012652 = Exercise-induced asthma
    - HP:0002615 = Hypotension
    - HP:0001631 = Atrial septal defect


<input id="hpoInput" type="text" placeholder="Enter HPO terms or IDs">
<button id="sendBtn">Search</button>

<pre id="results"></pre>


<script>
document.getElementById("sendBtn").addEventListener("click", async () => {
  const input = document.getElementById("hpoInput").value;

  const res = await fetch("https://dynamic-manatee-fe5240.netlify.app/.netlify/functions/agent", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ hpo: input })
  });

  const data = await res.json();

  // Try to parse the reply as JSON array
  let terms;
  try {
    terms = JSON.parse(data.reply);
  } catch(e) {
    terms = [];
  }

  let html = "";

  if (terms.length > 0) {
    html += "<ul>";
    terms.forEach(term => {
      html += `<li>${term}</li>`;
    });
    html += "</ul>";
  } else {
    html = "<p>No HPO terms found.</p>";
  }

  document.getElementById("results").innerHTML = html;
});
</script>

