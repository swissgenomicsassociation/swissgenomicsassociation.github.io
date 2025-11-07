# Swiss Genomics Association Website

This is the public website for the [Swiss Genomics Association](https://swissgenomicsassociation.github.io), a national collaboration of volunteer experts from leading academic, federal, and industry organisations.

> 🌐 Live site: [swissgenomicsassociation.github.io](https://swissgenomicsassociation.github.io)
> 📂 GitHub repository: [github.com/swissgenomicsassociation/swissgenomicsassociation.github.io](https://github.com/swissgenomicsassociation/swissgenomicsassociation.github.io)

---

## Overview

The Swiss Genomics Association defines open, shared standards for the responsible use of genomics in human health, precision medicine, and research.  
It meets quarterly to review proposed topics of national importance, ensuring coordination between Swiss and international partners.  
The Association’s outputs include white papers, guidelines, and reviews that address the ethical, clinical, and financial aspects of national-scale genomics programmes.

**Languages**  
Deutsch: Schweizerische Genomik-Vereinigung  
Français: Association Suisse de Génomique  
Italiano: Associazione Svizzera di Genomica  
English: Swiss Genomics Association

---

## Security

This site uses Supabase for member authentication and profile storage. The public repository includes the **Supabase anon key**, which is safe to expose. This key only allows limited, policy-controlled access defined by Supabase Row Level Security (RLS). All edits and updates to member profiles require a verified user session obtained through Supabase’s email-based magic link login. Public pages, such as the member directory, can read selected non-sensitive fields (e.g. name, credentials, ORCID) under a read-only policy. No service or administrative keys are stored in this repository. All member data is intentionally public, and the database exists solely to allow users to edit and maintain their own public profile information. No service or administrative keys are stored in this repository.

---

## Local development

To build and serve the site locally:

```bash
bundle install
bundle exec jekyll serve
````

The site will be available at [http://localhost:4000](http://localhost:4000).

---

## Custom Jekyll Build Workflow

GitHub Pages uses a fixed Jekyll environment (Ruby 3.1.x, `github-pages` v232, Jekyll 3.10.0) and does not support external plugins such as `jekyll-multiple-languages-plugin`.
To enable newer Jekyll versions and custom plugins, this site is built with a GitHub Actions workflow defined in `.github/workflows/jekyll.yml`.
The workflow checks out the repository, sets up Ruby 3.1, installs dependencies with Bundler, builds the site using `bundle exec jekyll build`, and publishes the `_site` directory to GitHub Pages.
It supports Jekyll 4.x, additional plugins, and ensures consistent builds between local and hosted environments. Deployment runs automatically on each push to the `main` branch.

---

## Site structure

* Main content:

  * `*.md` — top-level pages (e.g. `about.md`)
  * `_releases/` — main results of our work as pages
  * `_team/` — member information
* Supporting files:

  * `_includes/`, `_layouts/`, `_data/`, `_sass/`, `assets/`

---

## Database structure

User info 
```sql
select 
  id,
  email,
  raw_user_meta_data,
  created_at,
  last_sign_in_at,
  phone,
  role
from auth.users
order by created_at desc;
```

Essential info 

```sql
select 
  id,
  email,
  created_at,
  last_sign_in_at
from auth.users
order by created_at desc;
```

User info and public profile

```sql
select 
  u.id,
  u.email,
  u.created_at,
  p.name,
  p.title,
  p.updated_at
from auth.users u
left join public.profiles p on p.id = u.id
order by u.created_at desc;
```

The Supabase project backing this site defines two public tables:
**`profiles`** (for member information) and **`deletion_requests`** (for account deletion logs).

Both are fully managed client-side through the Supabase JavaScript client using the anonymous key.

--- 
## Account deletion requests

0. Sanity dump all identifiable user data across auth and public tables (non sensitive)
``` sql
select
  au.id as user_id,
  au.email as auth_email,
  au.created_at as auth_created,
  au.last_sign_in_at,
  p.*
from auth.users au
left join public.profiles p on p.id = au.id
order by au.created_at desc;
```

1. create a minimal table to track deletions (run once)
``` sql
create table if not exists public.account_deletions (
  user_id uuid primary key,
  deleted_at timestamptz not null
);
```

2. sanity check: show all live user data before deletion
``` sql
select
  au.id as user_id,
  au.email as auth_email,
  au.created_at,
  au.last_sign_in_at,
  p.*
from auth.users au
left join public.profiles p on p.id = au.id
order by au.created_at desc;
```

3. full deletion script (run any time)
``` sql
begin;

-- store minimal deletion proof
insert into public.account_deletions (user_id, deleted_at)
select user_id, now()
from public.deletion_requests
where processed = false
on conflict (user_id) do nothing;

-- delete personal data
delete from public.profiles
where id in (select user_id from public.deletion_requests where processed = false);

delete from auth.users
where id in (select user_id from public.deletion_requests where processed = false);

-- mark deletion request handled (do not touch email column)
update public.deletion_requests
set processed = true
where processed = false;

commit;
```

4. Sanity - No deleted user should still exist:
``` sql
select d.user_id, p.id as profile, a.id as auth
from public.account_deletions d
left join public.profiles p on p.id = d.user_id
left join auth.users a on a.id = d.user_id
where p.id is not null or a.id is not null;
```

5. Sanity - Pending requests should be zero:
``` sql
select count(*) from public.deletion_requests where processed = false;
```

6. Sanity - Deletion log should contain only uuid + time:
``` sql
select * from public.account_deletions order by deleted_at desc;
```
---

### Custom email domain handling

Supabase magic links are single-use tokens. Some corporate mail filters (e.g. Trend Micro, Proofpoint) prefetch or rewrite these links, causing them to expire before the user clicks.

Use a **verified custom sender domain** to prevent this. Configure DNS for your domain with:

* **MX:** `mx01.mail.icloud.com`, `mx02.mail.icloud.com`
* **SPF:** `v=spf1 include:icloud.com ~all`
* **DKIM:** `sig1._domainkey → sig1.dkim.mail.icloud.com`
* **DMARC (optional):** `v=DMARC1; p=quarantine; aspf=r; adkim=r`

Then add the domain’s SMTP credentials in Supabase → Auth → Email Templates.
Magic links will send from your trusted domain (e.g. `auth@swissgenomicsassociation.ch`), ensuring they bypass filters and remain valid.

---

## Release sync

All Swiss Genomics Association projects are developed in separate repositories under the organisation domain, each producing versioned outputs such as manuscripts, datasets, or configuration files. The main website (`swissgenomicsassociation.github.io`) hosts the latest public releases from these projects. During the site build, the `sync_releases.sh` script automatically copies current release files from their respective repositories into the `assets/release/` directory, making them directly accessible for viewing or download, for example:
`https://swissgenomicsassociation.github.io/assets/release/mendelian_disease_interpretation/latest/mendelian_disease_interpretation_v1.pdf`.


## Contributions

This website is maintained by the Swiss Genomics Association.
External contributions are welcome through pull requests or issues submitted on GitHub.

---

## License

Website source code is released under the [MIT License](LICENSE).
All content © Swiss Genomics Association. All rights reserved.


