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

The public certificate data lives in [public/certificates.json](public/certificates.json). Open `/?admin=1` to use the static admin panel. The admin panel needs a GitHub token with `Contents: Read and write` permission for `Zarqawi2/zarqawi2.github.io`; the token is used only in the browser session and is not saved by the app.
