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
/* Force single-column layout regardless of theme or media queries */
#profile-wrapper {
  display: block !important;
}

#profile-wrapper .profile-section {
  width: 100% !important;
  margin-bottom: 2rem !important;
  padding: 1rem;
  border: 1px solid #ccc;
  border-radius: 8px;
  background: #fafafa;
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

.profile-section form div {
  display: flex;
  flex-direction: column;
}

.profile-section form label {
  font-weight: 500;
  margin-bottom: 0.3rem;
}

.profile-section form input,
.profile-section form textarea {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 1rem;
  box-sizing: border-box;
}

.profile-section form small {
  margin-top: 0.3rem;
  color: #666;
  font-size: 0.85rem;
  line-height: 1.3;
}

.form-checkbox {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
}

.form-checkbox label {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  cursor: pointer;
  font-weight: 500;
}

.form-checkbox input[type="checkbox"] {
  width: 18px;
  height: 18px;
  accent-color: #0070c9;
  flex-shrink: 0;
}

button#save {
  align-self: flex-start;
  background: #0070c9;
  color: #fff;
  border: none;
  border-radius: 6px;
  padding: 0.6rem 1.2rem;
  font-size: 1rem;
  cursor: pointer;
}

button#save:hover {
  background: #005fa3;
}

  .info-icon {
    display: inline-block;
    margin-left: 6px;
    text-decoration: none;
    background: #ddd;
    color: #333;
    font-weight: bold;
    border-radius: 50%;
    width: 16px;
    height: 16px;
    text-align: center;
    line-height: 16px;
    font-size: 12px;
    cursor: help;
  }
  .info-icon:hover {
    background: #bbb;
  }



</style>

<p id="msg">Loading...</p>

<div class="profile-wrapper" style="display:none;" id="profile-wrapper">

  <div class="profile-section" id="profile-view">
    <h2>Current public profile</h2>
    <p><strong>Name:</strong> <span id="v-name"></span></p>
    <p><strong>Specialty / Profession:</strong> <span id="v-title"></span></p>
    <p><strong>Credentials:</strong> <span id="v-credentials"></span></p>
    <p><strong>Biography:</strong> <span id="v-biotext"></span></p>
    <p><strong>Email:</strong> <span id="v-contact_email"></span></p>
    <p><strong>ORCID:</strong> <span id="v-orcid_id"></span></p>
    <p><strong>Email visibility:</strong> <span id="v-email_public"></span></p>
  </div>

  <div class="profile-section" id="profile-area">
    <h2>Enter or update your information</h2>

    <form id="profile-form" style="display:flex; flex-direction:column; gap:1rem;">
    <div>
      <label for="name">Full name
      <small style="color:#c00; font-weight:500;">
        (Required)
      </small>
</label>
      <input id="name" placeholder="e.g. Jane Doe" required>
    </div>

      <div>
        <label for="title">Specialty / Profession <small>(Optional)</small></label>
        <input id="title" placeholder="e.g. Bioinformatician">
      </div>

      <div>
        <label for="credentials">Credentials <small>(Optional)</small></label>
        <input id="credentials" placeholder="e.g. MSc, MD, PhD">
      </div>

      <div>
      <label for="biotext">Biography <small>(Optional)</small></label>
      <textarea 
        id="biotext" 
        maxlength="2000" 
        rows="8" 
        placeholder="Describe your background and current role (max 2000 characters)">
      </textarea>
      <small id="biotext-counter" style="color:#666;">0 / 2000</small>
    </div>
    
    <script>
      const bio = document.getElementById('biotext')
      const counter = document.getElementById('biotext-counter')
      bio.addEventListener('input', () => {
        counter.textContent = `${bio.value.length} / 2000`
      })
    </script>



<div>
  <label for="contact_email">Contact email <small>(Auto-filled by our system)</small></label>
  <input id="contact_email" disabled>
  <small style="color:#666;">
    Your account security is linked to your login email, which cannot be changed here. To use a different email address, please contact the administrator or delete your account and create a new one. Automated email change functionality is under development.
  </small>
</div>

    <div>
      <label for="orcid_id">
        ORCID iD <small>(Optional)</small>
        <a href="https://orcid.org" target="_blank" rel="noopener" 
           class="info-icon" title="ORCID is a unique researcher identifier that links your publications and professional work. Visit orcid.org to learn more.">?</a>
      </label>
      <input id="orcid_id" placeholder="e.g. https://orcid.org/0000-0001-8496-3725">
      <small style="color:#666;">
        Please enter your full ORCID link or the 16-digit identifier.
      </small>
    </div>


      <div class="form-checkbox">
        <label for="email_public">
          <input type="checkbox" id="email_public">
          <span>Display my email publicly on my profile</span>
        </label>
        <small>Leave unchecked to keep your email private.</small>
      </div>

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

  await supabase.auth.onAuthStateChange(async (event) => {
    if (event === 'SIGNED_IN') loadProfile()
  })

  const { data: { session } } = await supabase.auth.getSession()
  if (session) loadProfile()
  else document.getElementById('msg').textContent = 'Please log in first.'

  async function loadProfile() {
    document.getElementById('msg').style.display = 'none'
    document.getElementById('profile-wrapper').style.display = 'block'

    const { data: { user } } = await supabase.auth.getUser()
    const ownEmail = user?.email || ''

    // show authenticated email in both places
    const vEmail = document.getElementById('v-contact_email')
    const iEmail = document.getElementById('contact_email')
    if (iEmail) iEmail.value = ownEmail
    if (vEmail) {
      vEmail.innerHTML = ownEmail
        ? `<a href="mailto:${ownEmail}">${ownEmail}</a> <small style="color:#666">(visible only to you unless you enable public display)</small>`
        : `<span class="not-public">Your email will appear here automatically once you are signed in.</span>`
    }

    // fetch or seed profile
    let { data, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single()

    if (error && error.code === 'PGRST116') {
      const seed = { id: user.id, name: '', contact_email: ownEmail, email_public: false }
      await supabase.from('profiles').insert(seed)
      data = seed
    }

    const elName = document.getElementById('name')
    const elTitle = document.getElementById('title')
    const elCred = document.getElementById('credentials')
    const elBio  = document.getElementById('biotext')
    const elOrc  = document.getElementById('orcid_id')
    const elEmailPublic = document.getElementById('email_public')

    // only editable fields here
    const fields = { name: elName, title: elTitle, credentials: elCred, biotext: elBio, orcid_id: elOrc }

    for (const key in fields) {
      const val = data?.[key] || ''
      if (fields[key]) fields[key].value = val
      const vEl = document.getElementById('v-' + key)
      if (vEl) {
        if (key === 'orcid_id' && val) {
          const href = val.startsWith('http') ? val : 'https://orcid.org/' + val
          vEl.innerHTML = `<a href="${href}" target="_blank" rel="noopener">${href}</a>`
        } else {
          vEl.textContent = val
        }
      }
    }

    const isPublic = data?.email_public ?? false
    if (elEmailPublic) elEmailPublic.checked = isPublic
    const vEmailPublic = document.getElementById('v-email_public')
    if (vEmailPublic) vEmailPublic.textContent = isPublic ? 'Public' : 'Hidden'

    document.getElementById('save').onclick = async () => {
      const fullName = elName.value.trim()
      if (!fullName || fullName.split(/\s+/).length < 2 || fullName.length < 4) {
        alert('Please enter your full name (first and last name).')
        return
      }

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
        name: fullName,
        title: elTitle.value.trim() || null,
        credentials: elCred.value.trim() || null,
        biotext: elBio.value.trim() || null,
        contact_email: ownEmail,
        orcid_id: orcid || null,
        email_public: elEmailPublic.checked
      }

      const { error } = await supabase.from('profiles').upsert(profile, { onConflict: 'id' })
      if (error) { alert('Error: ' + error.message); return }

      alert('Profile saved')

      // update view
      const vOrcid = document.getElementById('v-orcid_id')
      if (vOrcid) {
        vOrcid.innerHTML = profile.orcid_id
          ? `<a href="${profile.orcid_id}" target="_blank" rel="noopener">${profile.orcid_id}</a>`
          : ''
      }
      const vName = document.getElementById('v-name')
      if (vName) vName.textContent = profile.name || ''
      const vTitle = document.getElementById('v-title')
      if (vTitle) vTitle.textContent = profile.title || ''
      const vCred = document.getElementById('v-credentials')
      if (vCred) vCred.textContent = profile.credentials || ''
      const vBio = document.getElementById('v-biotext')
      if (vBio) vBio.textContent = profile.biotext || ''
      const vPub = document.getElementById('v-email_public')
      if (vPub) vPub.textContent = profile.email_public ? 'Public' : 'Hidden'
      const vEmailNote = document.getElementById('v-contact_email')
      if (vEmailNote) {
        const note = profile.email_public
          ? '<small style="color:#666">(public on your member page)</small>'
          : '<small style="color:#666">(visible only to you unless you enable public display)</small>'
        vEmailNote.innerHTML = `<a href="mailto:${ownEmail}">${ownEmail}</a> ${note}`
      }
    }
  }

  document.getElementById('delete-account').onclick = async () => {
    const confirmDelete = confirm(
      'Are you sure you want to permanently delete your account and all associated profile data? This action cannot be undone.'
    )
    if (!confirmDelete) return
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) { alert('Please log in first.'); return }
    const inputEmail = prompt('Please confirm your email address to proceed:')
    if (!inputEmail || inputEmail.trim().toLowerCase() !== user.email.toLowerCase()) {
      alert('Email confirmation does not match your account. Deletion cancelled.')
      return
    }
    const { error } = await supabase.from('deletion_requests').insert({
      user_id: user.id,
      email: user.email,
      requested_at: new Date().toISOString()
    })
    if (error) { alert('Error submitting deletion request: ' + error.message); return }
    alert('Your account deletion request has been received. For your security, the deletion will be reviewed and processed by an administrator.')
    await supabase.auth.signOut()
    window.location.href = '/'
  }
</script>


<div style="margin-top:2rem; padding-top:1rem; border-top:1px solid #ccc;">
  <button type="button" id="delete-account" style="background:#b33;color:#fff;padding:0.6rem 1rem;border:none;border-radius:6px;">
    Delete my account
  </button>
  <p style="margin-top:0.8rem;font-size:0.9rem;color:#555;">
    If you have any issues, please <a href="mailto:dylan@swissgenomics.ch">contact the administrator</a>.
  </p>
</div>

