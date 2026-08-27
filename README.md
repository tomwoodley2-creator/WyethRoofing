# Wyeth Roofing Limited — website

Single-page marketing site for Wyeth Roofing Limited (Berkshire roofers).

- `index.html` — the whole site (Tailwind via CDN, all styles inline, no build step)
- `assets/` — logo
- `Brand/` — brand assets, guidelines and vector artwork
- `serve.ps1` — minimal local static server (`http://localhost:3000`)
- `screenshot.ps1` — headless-Chrome screenshot helper

## Run locally

```powershell
powershell -File serve.ps1
# open http://localhost:3000
```

## Deploy

The site is static — `index.html` at the repo root. Host it with GitHub Pages,
Netlify, Cloudflare Pages, or any static host. For a custom domain on GitHub Pages,
add a `CNAME` file containing the domain and point DNS at GitHub.

## Still to wire

- Checkatrade widgets render only on the approved live domain (company id `1135999`).
- Project-card images are placeholders; review quotes and case studies are illustrative.
- The hero backdrop is an SVG illustration — swap in a real roof photo when available.
