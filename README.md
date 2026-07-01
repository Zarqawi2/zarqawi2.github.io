# CertVault

A Vite/Vue website for browsing and installing iOS certificate profiles, MDM profiles, VPN profiles, and configuration files.

## Development

```bash
npm install
npm run dev
```

## Production Build

```bash
npm run build
```

## Deploying to GitHub Pages

1. Push the project to GitHub.
2. In `Settings` -> `Pages`, choose `GitHub Actions` as the source.
3. The deployment workflow will publish the built site.

The public certificate data lives in [public/certificates.json](public/certificates.json). The admin panel is disabled in production GitHub Pages builds. To use it, run the site locally with `npm run dev` and open `http://127.0.0.1:5173/?admin=1`. It needs a GitHub token with `Contents: Read and write` permission for `Zarqawi2/zarqawi2.github.io`; the token is used only in the browser session and is not saved by the app.
