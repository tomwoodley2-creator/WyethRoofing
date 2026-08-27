# Wyeth Roofing Limited — website

Static marketing site for Wyeth Roofing Limited (Berkshire roofers).

- `index.html` — the main page
- `privacy.html`, `cookies.html`, `404.html` — supporting pages
- `robots.txt`, `sitemap.xml` — crawler files
- `src/input.css` + `tailwind.config.js` — Tailwind source; builds to `assets/tailwind.css`
- `assets/` — logo, favicon, built CSS, social share image
- `Brand/` — brand assets, guidelines and vector artwork
- `serve.ps1` — minimal local static server (`http://localhost:3000`)
- `screenshot.ps1` — headless-Chrome screenshot helper

## Run locally

```powershell
powershell -File serve.ps1
# open http://localhost:3000
```

## Build the CSS

Styling is compiled ahead of time with the Tailwind standalone CLI (no Node needed).
The 40 MB binary is git-ignored — download it once per machine:

```powershell
Invoke-WebRequest -Uri "https://github.com/tailwindlabs/tailwindcss/releases/download/v3.4.17/tailwindcss-windows-x64.exe" -OutFile tailwindcss.exe
```

Then rebuild whenever markup or `src/input.css` changes:

```powershell
.\tailwindcss.exe -c ./tailwind.config.js -i ./src/input.css -o ./assets/tailwind.css --minify
```

Commit the regenerated `assets/tailwind.css` — the host serves it directly.

## Deploy

The site is static. Host it with Cloudflare Pages, Netlify, GitHub Pages, or any
static host. Set the domain to `wyethroofing.co.uk` and update the absolute URLs in
`sitemap.xml`, `robots.txt`, and the `og:`/`canonical` tags if it ever changes.

## Still to wire

- Checkatrade widgets render only on the approved live domain (company id `1135999`).
- Project-card images are placeholders; review quotes and case studies are illustrative.
- The hero backdrop is an SVG illustration — swap in a real roof photo when available.
- Add `wyethroofing.co.uk` to the Cookiebot dashboard and run a scan so the banner
  and cookie declaration populate.
- Confirm opening hours in the JSON-LD (`index.html`) — currently Mon–Sat 08:00–18:00.
