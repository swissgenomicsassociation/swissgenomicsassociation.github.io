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


Here’s a clean, README-ready section you can add directly to your project’s documentation:

---

### Database structure

The Supabase instance for this site uses a single public table, **`profiles`**, which stores all member profile data.
You can reproduce the live schema using the following SQL queries.

```sql
SELECT table_schema,
       table_name,
       column_name,
       data_type,
       is_nullable,
       column_default
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;
```

| table_schema | table_name | column_name   | data_type                | is_nullable | column_default |
| ------------ | ---------- | ------------- | ------------------------ | ----------- | -------------- |
| public       | profiles   | id            | uuid                     | NO          | null           |
| public       | profiles   | name          | text                     | YES         | null           |
| public       | profiles   | credentials   | text                     | YES         | null           |
| public       | profiles   | biotext       | text                     | YES         | null           |
| public       | profiles   | contact_email | text                     | YES         | null           |
| public       | profiles   | orcid_id      | text                     | YES         | null           |
| public       | profiles   | updated_at    | timestamp with time zone | YES         | now()          |
| public       | profiles   | title         | text                     | YES         | null           |

You can list all tables in the current schema using:

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
```

| table_name |
| ---------- |
| profiles   |

---

This confirms that only one public table, `profiles`, is currently used by the Supabase backend for all member profile storage.

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


