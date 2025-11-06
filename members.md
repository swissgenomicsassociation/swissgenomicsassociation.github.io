---
layout: page
description: Members
intro_image_absolute: true
intro_image_hide_on_mobile: false
intro_image: "images/freepik_vectorjuice/distance-working.jpg"
---

{% translate_file members.md %}

<style>
  .member-card {
    border: 1px solid #ddd;
    padding: 1rem;
    margin: 0.5rem 0;
    border-radius: 8px;
    background: #fafafa;
  }
  .member-card h3 {
    margin: 0 0 0.3rem 0;
  }
  .member-card p {
    margin: 0.2rem 0;
  }
</style>

<div id="members">Loading...</div>

<script type="module">
  import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

  const supabase = createClient(
    'https://pjslulmnfxtfihdtzrbu.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBqc2x1bG1uZnh0ZmloZHR6cmJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIyNjEzODUsImV4cCI6MjA3NzgzNzM4NX0.7fPGKu7rbziVGl4X5T2qVoqu0Yt0enR4lisYq3sdnMY'
  )

  const container = document.getElementById('members')

  const { data, error } = await supabase
    .from('profiles')
    .select('id, name, credentials, title, orcid_id')
    .order('name')

  if (error) {
    container.textContent = 'Error loading members.'
  } else if (!data || data.length === 0) {
    container.textContent = 'No members found.'
  } else {
    container.innerHTML = data.map(p => {
      const nameText = [p.name, p.credentials].filter(Boolean).join(', ') || '(Unnamed)'
      const nameHTML = `<a href="/member/?id=${p.id}" class="member-link">${nameText}</a>`

      const titleHTML = p.title
        ? `<p><strong>${p.title}</strong></p>`
        : ''

      const orcidHTML = p.orcid_id
        ? `<p><a href="${p.orcid_id}" target="_blank">${p.orcid_id}</a></p>`
        : ''

      return `
        <div class="member-card">
          <h3>${nameHTML}</h3>
          ${titleHTML}
          ${orcidHTML}
        </div>
      `
    }).join('')
  }
</script>

