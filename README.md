# Switzerland Omics Website

This is the public website for [Switzerland Omics](https://switzerlandomics.ch), a Zurich-based genomics technology company building statistical frameworks, inference systems, and omic tools for bleeding-edge tech.

> 🌐 Live site: [switzerlandomics.ch](https://switzerlandomics.ch)  
> 📂 Site git: (here) [github.com/switzerlandomics.github.io](https://github.com/DylanLawless/switzerlandomics.github.io)  
> 📘 Technical docs: [docs.switzerlandomics.ch](https://docs.switzerlandomics.ch)  
> 📂 Docs git: [github.com/docs-switzerlandomics.github.io](https://github.com/docs-switzerlandomics.github.io)

---

## Overview

The main website is a static Jekyll site styled for clarity, minimalism, and credibility.  
It introduces Switzerland Omics' products (e.g. **Quant**, **PanelAppRex AI**), outlines our approach to variant interpretation, and includes information about partnerships, research, and contact.

Some parts of the broader Switzerland Omics web stack use additional infrastructure including:

- 🔧 **Netlify functions** support on-demand content and integrations, including AI agents  
- 🧬 A separate authenticated platform (customer-facing) uses:
  - **Next.js 15 (Turbopack)**  
  - **Supabase** for auth, database, and storage  
  - **Stripe** for one-time payments  
  - **Drizzle ORM**, **Tailwind CSS**, and **Radix UI**

These systems are not part of the main static site but are developed internally under `~/so`, alongside `~/so/web/switzerlandomics.ch`, on dedicated company infrastructure.

---

## Local development

To serve the static site locally:

```bash
sh jek.sh
sh kill_serve.sh
````

This will stop and start the testing env, equivalent to: 

```bash
bundle install
bundle exec jekyll serve
````

Site runs at [http://localhost:4000](http://localhost:4000).

---

## Site structure

* Main content pages include:
	- `*.md` - top-level pages (e.g. `about.md`, `technologies.md`, `pitch.md`)
	- `_technologies/` - the main product pages such as `quant.md`
* Supporting pages:
	- `_includes/` - reusable components (e.g. callout boxes)
	- `_layouts/` - page templates
	- `_data/` - contact metadata and config
	- `_sass/` - custom styling rules
	- `assets/` - images, fonts, and design assets

---

## Contributions

This site is maintained by the Switzerland Omics team.
External contributions are not accepted at this time.
Valid pull requests are appreciated, likely to be accepted, and used.
If you notice an issue, feel free to open one.

For technical frameworks and probabilistic inference tooling, see our [documentation portal](https://docs.switzerlandomics.ch).

---

## License

Website source code is released under the [MIT License](LICENSE).
All content, trademarks, and product names are © Switzerland Omics. All rights reserved.

