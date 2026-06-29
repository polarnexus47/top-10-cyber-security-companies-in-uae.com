# top-10-cyber-security-companies-in-uae.com

Independent ranking of the top 10 cyber security companies in UAE. Static site built for GitHub Pages.

## Architecture

```
├── index.html                    ← Built output (never edit directly)
├── about/index.html              ← Built output
├── editorial-policy/index.html   ← Built output
├── how-we-evaluate/index.html    ← Built output
├── submit/index.html             ← Built output
├── contact/index.html            ← Built output
├── components/
│   ├── header.html               ← Shared nav
│   └── footer.html               ← Shared footer
├── content/
│   ├── top-10-cyber-security-companies-in-uae.html
│   ├── about.html
│   ├── editorial-policy.html
│   ├── how-we-evaluate.html
│   ├── submit.html
│   └── contact.html
├── css/
│   ├── global.css                ← Reset, typography, header, footer
│   └── ranking.css               ← Page-specific styles
├── images/
│   └── logo.svg
├── js/
│   └── nav.js                    ← Mobile nav toggle only
├── favicon.svg
├── build.sh                      ← Assembles all pages
├── serve.mjs                     ← Local dev server
├── sitemap.xml
├── robots.txt
└── .nojekyll                     ← Required for GitHub Pages
```

## Build

```bash
bash build.sh
```

Produces all 6 `index.html` files with relative paths, injected `<head>`, and schema markup.

## Local preview

```bash
node serve.mjs
# then open http://localhost:3000
```

## Deploy to GitHub Pages

```bash
git init -b main
git config user.name "username"
git config user.email "username@users.noreply.github.com"
git add .
git commit -m "Initial build"
git remote add origin https://github.com/USERNAME/REPO.git
git push -u origin main
```

Then: Repo → Settings → Pages → Source: `main` / `/(root)` → Save.

## Update workflow

Edit files in `content/`, `components/`, `css/`, or `js/` — then:

```bash
bash build.sh
git add -A
git commit -m "Description"
git push
```

GitHub Pages redeploys in ~1 minute.
