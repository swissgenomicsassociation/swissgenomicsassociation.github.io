---
layout: page
description: Login or join
intro_image_absolute: true
intro_image_hide_on_mobile: false
---

{% translate_file login.html %}

<form id="login-form">
  <input id="email" type="email" placeholder="Email" required>
  <button type="submit">Send magic link</button>
</form>
<p id="msg"></p>

<script type="module">
  import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

  const supabase = createClient(
    'https://pjslulmnfxtfihdtzrbu.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBqc2x1bG1uZnh0ZmloZHR6cmJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIyNjEzODUsImV4cCI6MjA3NzgzNzM4NX0.7fPGKu7rbziVGl4X5T2qVoqu0Yt0enR4lisYq3sdnMY'
  )

  // redirect if already logged in
  const { data: { session } } = await supabase.auth.getSession()
  if (session) window.location.href = '/profile/'

  // handle login form
  document.getElementById('login-form').addEventListener('submit', async (e) => {
    e.preventDefault()
    const msg = document.getElementById('msg')
    msg.textContent = 'Sending magic link...'

    const email = document.getElementById('email').value.trim()
    const { error } = await supabase.auth.signInWithOtp({
      email,
      options: { emailRedirectTo: window.location.origin + '/auth/callback.html' }

    })

    if (error) {
      if (error.message.includes('Database error')) {
        // suppress irrelevant backend error
        msg.textContent = 'Magic link sent. Please check your email.'
      } else {
        msg.textContent = 'Error: ' + error.message
      }
    } else {
      msg.textContent = 'Magic link sent. Please check your email.'
    }
  })
</script>


