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


### Database structure

The Supabase project backing this site defines two public tables:
**`profiles`** (for member information) and **`deletion_requests`** (for account deletion logs).

Both are fully managed client-side through the Supabase JavaScript client using the anonymous key.

#### 1. `profiles` table

Stores all public and private member information.
Each profile row corresponds one-to-one with a Supabase Auth user (`auth.users.id`).

```sql
create table public.profiles (
  id uuid primary key references auth.users (id),
  name text,
  credentials text,
  biotext text,
  contact_email text,
  orcid_id text,
  updated_at timestamp with time zone default now(),
  title text,
  email_public boolean default false
);
```

**Notes**

* `email_public` defaults to `false`, so user email addresses are hidden unless explicitly made public.
* The authenticated user’s `id` acts as the primary key and foreign key to `auth.users`.
* The `contact_email` field mirrors the verified Supabase Auth email and is read-only in the client interface.

#### 2. `deletion_requests` table

Logs user-initiated requests for account removal.
These are created client-side and manually processed by an administrator.

```sql
create table public.deletion_requests (
  id bigint generated always as identity primary key,
  user_id uuid not null,
  email text not null,
  requested_at timestamp with time zone default now(),
  processed boolean default false
);
```

**Notes**

* A record is inserted whenever a signed-in user submits a deletion request.
* `processed` remains `false` until an administrator confirms deletion.
* No automatic deletion is executed client-side.

#### 3. Inspecting the schema

To view all tables:

```sql
select table_name
from information_schema.tables
where table_schema = 'public'
order by table_name;
```

To list all columns for verification:

```sql
select table_schema,
       table_name,
       column_name,
       data_type,
       is_nullable,
       column_default
from information_schema.columns
where table_schema = 'public'
order by table_name, ordinal_position;
```

**Expected output**

| table_name        | purpose                               |
| ----------------- | ------------------------------------- |
| profiles          | Stores all member profile information |
| deletion_requests | Logs account deletion submissions     |

---

This schema represents the complete and current Supabase configuration used by the live Swiss Genomics Association website.

## Account deletion

To list all recorded deletion requests (for admin review or verification), you can run:

```sql
select
  id,
  user_id,
  email,
  requested_at,
  processed
from public.deletion_requests
order by requested_at desc;
```

If you only want to see pending (unprocessed) requests:

```sql
select
  id,
  user_id,
  email,
  requested_at
from public.deletion_requests
where processed = false
order by requested_at desc;
```

And to quickly count how many are still pending:

```sql
select count(*) as pending_requests
from public.deletion_requests
where processed = false;
```

To validate the count of all legally valid users

```sql
select count(*) as active_accounts
from public.profiles
where id not in (
  select user_id from public.deletion_requests
);
```

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


