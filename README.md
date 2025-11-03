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

## Contributions

This website is maintained by the Swiss Genomics Association.
External contributions are welcome through pull requests or issues submitted on GitHub.

---

## License

Website source code is released under the [MIT License](LICENSE).
All content © Swiss Genomics Association. All rights reserved.


