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

The page content, certificates, categories, and install links live in [src/App.vue](src/App.vue).
