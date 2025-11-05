---
layout: page
description: profile
intro_image_absolute: true
intro_image_hide_on_mobile: false
permalink: /profile/
---

<h1>Your profile</h1>

<button id="logout">Log out</button>

<style>
  .profile-wrapper {
    display: flex;
    flex-wrap: wrap;
    gap: 2rem;
    margin-top: 1rem;
  }
  .profile-section {
    flex: 1 1 300px;
    padding: 1rem;
    border: 1px solid #ccc;
    border-radius: 8px;
    background: #fafafa;
  }
  .profile-section h2 {
    margin-top: 0;
  }
  label {
    display: block;
    margin-bottom: 0.5rem;
  }
  input, textarea {
    width: 100%;
    margin-bottom: 1rem;
    padding: 0.4rem;
  }
  button {
    padding: 0.5rem 1rem;
  }
  .checkbox-label {
    display: flex;
    align-items: center;
    gap: 0.4rem;
  }
</style>

<p id="msg">Loading...</p>

<div class="profile-wrapper" style="display:none;" id="profile-wrapper">

  <div class="profile-section" id="profile-view">
    <h2>Current public profile</h2>
    <p><strong>Name:</strong> <span id="v-name"></span></p>
    <p><strong>Title / Specialty:</strong> <span id="v-title"></span></p>
    <p><strong>Credentials:</strong> <span id="v-credentials"></span></p>
    <p><strong>Bio:</strong> <span id="v-biotext"></span></p>
    <p><strong>Email:</strong> <span id="v-contact_email"></span></p>
    <p><strong>ORCID:</strong> <span id="v-orcid_id"></span></p>
    <p><strong>Email visibility:</strong> <span id="v-email_public"></span></p>
  </div>

  <div class="profile-section" id="profile-area">
    <h2>Enter or update your information</h2>
    <form id="profile-form">
      <label>Name<br><input id="name"></label>
      <label>Title / Specialty<br><input id="title" placeholder="e.g. Bioinformatician"></label>
      <label>Credentials<br><input id="credentials"></label>
      <label>Bio<br><textarea id="biotext"></textarea></label>
      <label>Contact email<br><input id="contact_email"></label>
      <label>
        ORCID iD<br>
        <input id="orcid_id" placeholder="e.g. https://orcid.org/0000-0001-8496-3725">
      </label>
      <label class="checkbox-label">
        <input type="checkbox" id="email_public"> Show email publicly
      </label>
      <small>Please enter your full ORCID link or the 16-digit identifier.</small><br><br>
      <button type="button" id="save">Save</button>
    </form>
  </div>

</div>

<script type="module">
  import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

  const supabase = createClient(
    'https://pjslulmnfxtfihdtzrbu.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBqc2x1bG1uZnh0ZmloZHR6cmJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIyNjEzODUsImV4cCI6MjA3NzgzNzM4NX0.7fPGKu7rbziVGl4X5T2qVoqu0Yt0enR4lisYq3sdnMY'
  )

  document.getElementById('logout').onclick = async () => {
    await supabase.auth.signOut()
    window.location.href = '/login/'
  }

  await supabase.auth.onAuthStateChange(async (event, session) => {
    if (event === 'SIGNED_IN') loadProfile()
  })

  const { data: { session } } = await supabase.auth.getSession()
  if (session) {
    loadProfile()
  } else {
    document.getElementById('msg').textContent = 'Please log in first.'
  }

  async function loadProfile() {
    document.getElementById('msg').style.display = 'none'
    document.getElementById('profile-wrapper').style.display = 'flex'

    const { data: { user } } = await supabase.auth.getUser()
    let { data, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single()

    if (error && error.code === 'PGRST116') {
      await supabase.from('profiles').insert({ id: user.id, name: '' })
      data = { name: '', title: '', credentials: '', biotext: '', contact_email: '', orcid_id: '', email_public: true }
    }

    const elName = document.getElementById('name')
    const elTitle = document.getElementById('title')
    const elCred = document.getElementById('credentials')
    const elBio  = document.getElementById('biotext')
    const elMail = document.getElementById('contact_email')
    const elOrc  = document.getElementById('orcid_id')
    const elEmailPublic = document.getElementById('email_public')

    const fields = { name: elName, title: elTitle, credentials: elCred, biotext: elBio, contact_email: elMail, orcid_id: elOrc }

    for (const key in fields) {
      const val = data?.[key] || ''
      fields[key].value = val
      const vEl = document.getElementById('v-' + key)
      if (vEl) {
        if (key === 'orcid_id' && val) {
          vEl.innerHTML = `<a href="${val}" target="_blank">${val}</a>`
        } else {
          vEl.textContent = val
        }
      }
    }

    elEmailPublic.checked = data?.email_public ?? true
    document.getElementById('v-email_public').textContent = elEmailPublic.checked ? 'Public' : 'Hidden'

    document.getElementById('save').onclick = async () => {
      let orcid = elOrc.value.trim()
      const orcidPattern = /^(https:\/\/orcid\.org\/)?\d{4}-\d{4}-\d{4}-\d{3}[\dX]$/
      if (orcid && !orcidPattern.test(orcid)) {
        alert('Please enter a valid ORCID iD (e.g. https://orcid.org/0000-0001-8496-3725)')
        return
      }
      if (orcid && !orcid.startsWith('https://orcid.org/')) {
        orcid = 'https://orcid.org/' + orcid
      }

      const profile = {
        id: user.id,
        name: elName.value.trim() || null,
        title: elTitle.value.trim() || null,
        credentials: elCred.value.trim() || null,
        biotext: elBio.value.trim() || null,
        contact_email: elMail.value.trim() || null,
        orcid_id: orcid || null,
        email_public: elEmailPublic.checked
      }

      const { error } = await supabase.from('profiles').upsert(profile, { onConflict: 'id' })
      if (error) {
        alert('Error: ' + error.message)
        return
      }

      alert('Profile saved')

      for (const k in profile) {
        const vEl = document.getElementById('v-' + k)
        if (vEl) {
          if (k === 'orcid_id' && profile[k]) {
            vEl.innerHTML = `<a href="${profile[k]}" target="_blank">${profile[k]}</a>`
          } else if (k === 'email_public') {
            vEl.textContent = profile[k] ? 'Public' : 'Hidden'
          } else {
            vEl.textContent = profile[k] || ''
          }
        }
      }
    }
  }
</script>

