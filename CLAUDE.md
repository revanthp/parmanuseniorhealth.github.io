# Parmanu Seniors Health — Claude Rules

Website for DAE pensioners and CHSS beneficiaries. Audience is senior citizens; accessibility and plain language are non-negotiable.

**Live site:** https://paramanuseniorshealth.org

---

## Stack at a Glance

| Layer | Technology |
|-------|-----------|
| SSG | Hugo 0.145.0 |
| Theme | Custom fork of `hugo-bootstrap-theme` (Bootstrap 5) — git submodule at `themes/hugo-bootstrap-theme` |
| CMS | Decap CMS — config at `static/admin/config.yml` |
| CMS auth | Cloudflare Worker at `decap.paramanuseniorshealth.org` |
| Hosting | GitHub Pages |
| CI/CD | GitHub Actions — `.github/workflows/hugo.yml` |
| Analytics | GA4 `G-BGSPDZEPPY` + GTM `GTM-PPG22D5B` |

---

## Hugo Rules

- **Build command:** `hugo --gc --minify` (production always includes both flags)
- **Config lives in `config/_default/`** — never hardcode base URL or site params inline
- **Theme is a git submodule** — always checkout with `--recurse-submodules`; never edit files inside `themes/` directly; patch via layout overrides in `layouts/`
- **Layout overrides** go in `layouts/` mirroring the theme path (e.g. `layouts/partials/navbar.html` overrides the theme partial)
- **Hugo version is pinned at 0.145.0** — do not suggest upgrading without checking the CI workflow and submodule compatibility first
- **Content front matter** uses TOML (`.md` files with `+++` delimiters); follow the archetype at `archetypes/default.md`
- **Required front matter fields:** `title`, `date`, `lastmod`, `draft`, `weight`, `type`, `layout`
- **Slug format:** `YYYY-{{slug}}` — matches the Decap CMS slug pattern
- **`public/` and `resources/` are build artifacts** — never commit them; they are gitignored
- Run `hugo server` for local dev; no flags needed beyond that

### Content sections

| Folder | Menu parent |
|--------|------------|
| `content/pension/` | Pensioners' Corner |
| `content/health-matters/` | Health Matters |
| `content/tel-numbers/` | Telephone numbers |
| `content/general-services/` | General Information |

---

## Decap CMS Rules

- **Config:** `static/admin/config.yml` — single source of truth for all CMS fields
- **Backend:** GitHub OAuth via implicit flow; auth worker at `decap.paramanuseniorshealth.org`
- **Media:** uploaded to `static/files/`; public path is `/files/`
- **Editorial workflow is enabled** — CMS saves open a PR; publishing merges it; this triggers CI/CD
- **`delete: false`** on all collections — content is never deleted via CMS
- **YAML anchors** are used extensively for DRY field definitions (`&title`, `&date`, etc.) — reuse them, don't duplicate field objects
- When adding a new collection, copy the `<<: *collection_defaults` merge key and add the appropriate `menu.main.parent` hidden field
- Do not disable `squash_merges: true` — keeps main branch history clean

---

## CI/CD Rules

- **Trigger:** push to `main` or manual `workflow_dispatch`
- **Hugo version** is set via `HUGO_VERSION` env var in the workflow — update there and in `.github/actions/install-dependencies/` together
- **Submodules must be checked out** — `actions/checkout@v4` uses `submodules: recursive`
- **`fetch-depth: 0`** is required for Hugo's `.GitInfo` and `lastmod` features
- **Cache keys:** Hugo CLI keyed by version, npm keyed by `package-lock.json` hash, Hugo modules keyed by `go.sum` hash — update cache keys when dependencies change
- **Build artifacts are cleaned** before every build (`rm -rf public resources .hugo_build.lock`)
- **`HUGO_ENVIRONMENT=production`** must be set for production builds
- **Permissions** are minimal: `contents: read`, `pages: write`, `id-token: write` — do not add broader permissions
- Never push directly to `main` when CI is broken; fix the workflow first

---

## Accessibility & Styling

All typography, contrast, touch target, navigation, and performance constraints are defined in `.rules` — treat every entry there as a hard requirement, not a suggestion.

Key non-negotiables: min 16 px font, WCAG AA contrast (4.5:1), 40 px touch targets, left-aligned text, plain language, PDF labels on all download links, font resizer widget (`layouts/partials/font-resizer.html`) must remain in the navbar.

---

## Content Style Guide

- Page structure: purpose → core info → resources/links (in that order)
- Use the same term consistently across all pages (e.g. don't mix "CHSS" and "health scheme")
- Headings must summarize the content below them — no generic headings like "Information"
- Prefer HTML content over PDF for key information; link to PDFs as supplements
- Keep paragraphs short; use bullet lists for multi-item information
- Do not embed large images or videos — optimize for low-bandwidth connections

---

## What NOT to Do

- Do not edit files inside `themes/hugo-bootstrap-theme/` — use layout overrides instead
- Do not commit `public/`, `resources/`, or `.hugo_build.lock`
- Do not remove `squash_merges: true` from `static/admin/config.yml`
- Do not add `draft: true` to content that should be live
- Do not use justified text or font sizes below 16 px
- Do not bypass the editorial workflow (direct commits to `main` skip CMS review)
- Do not add Node dependencies without updating `package-lock.json`
- Do not skip `--recurse-submodules` when cloning

---

## Local Development

```bash
# First clone
git clone --recurse-submodules https://github.com/revanthp/parmanuseniorhealth.github.io.git

# Serve locally
hugo server

# Production build (mirrors CI)
hugo --gc --minify
```

Requires Hugo 0.145.0+ and Dart Sass.
