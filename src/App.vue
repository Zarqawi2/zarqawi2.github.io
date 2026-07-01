<script setup lang="ts">
import { computed, ref } from "vue";
import type { Component } from "vue";
import {
  BadgeCheck,
  Building2,
  CheckCircle2,
  ChevronLeft,
  Download,
  FileCheck2,
  FlaskConical,
  GraduationCap,
  Network,
  Search,
  Settings,
  ShieldCheck,
  Smartphone,
  Wifi,
  Wrench,
  Zap,
} from "lucide-vue-next";

type Category = "All" | "Enterprise" | "Development" | "MDM Profile" | "VPN" | "Education" | "Custom";
type Tone = "blue" | "violet" | "green" | "orange" | "cyan";

type Certificate = {
  name: string;
  subtitle: string;
  description: string;
  category: Exclude<Category, "All">;
  issuer: string;
  installs: string;
  validFor: string;
  installKey: string;
  tone: Tone;
  icon: Component;
  featured?: boolean;
  badge?: string;
  warning?: boolean;
};

const categories: Category[] = ["All", "Enterprise", "Development", "MDM Profile", "VPN", "Education", "Custom"];

const categoryLabels: Record<Category, string> = {
  All: "هەموو",
  Enterprise: "کارگێڕی",
  Development: "گەشەپێدان",
  "MDM Profile": "پرۆفایلی MDM",
  VPN: "VPN",
  Education: "پەروەردە",
  Custom: "تایبەت",
};

const certificates: Certificate[] = [
  {
    name: "پرۆفایلی تەواوی Enterprise",
    subtitle: "Apple Inc.",
    description: "بەڵگەنامەی تەواوی Apple Enterprise بۆ دامەزراندنی ڕاستەوخۆی iOS و دەستگەیشتنی نەرمەکاڵا لەسەر هەر ئامێرێکی iOS.",
    category: "Enterprise",
    issuer: "Apple Enterprise",
    installs: "٢.٨ هەزار",
    validFor: "١ ساڵ",
    installKey: "XL",
    tone: "blue",
    icon: Building2,
    featured: true,
    badge: "زۆرترین بەکارهێنان",
  },
  {
    name: "پرۆفایلی تۆمارکردنی MDM",
    subtitle: "Smart Pro",
    description: "پرۆفایلی تۆمارکردنی Mobile Device Management بۆ بەڕێوەبردنی دوورەوە، جێبەجێکردنی ڕێساکان، و دابەشکردنی نەرمەکاڵا.",
    category: "MDM Profile",
    issuer: "MDM ـی دوورەوە",
    installs: "١٤٣ هەزار",
    validFor: "بێ سنوور",
    installKey: "National",
    tone: "violet",
    icon: Smartphone,
    featured: true,
    badge: "پێشنیارکراو",
  },
  {
    name: "ڕێکخستنی VPN",
    subtitle: "Crescent VPN",
    description: "بەڵگەنامەی VPN ـی کۆمپانیا و پرۆفایلی تونێلی کۆدکراو بۆ دەستگەیشتنی پارێزراو لەسەر iPhone و iPad.",
    category: "VPN",
    issuer: "متمانەی تۆڕ",
    installs: "٨٩ هەزار",
    validFor: "٢ ساڵ",
    installKey: "Rural",
    tone: "green",
    icon: ShieldCheck,
  },
  {
    name: "بەڵگەنامەی گەشەپێدان",
    subtitle: "Apple Developer Program",
    description: "بەڵگەنامەی ستانداردی Apple Developer بۆ تاقیکردنەوە و دابەشکردنی ئەپەکان لەسەر ئامێرە تۆمارکراوەکان.",
    category: "Development",
    issuer: "Apple Developer",
    installs: "٨٧ هەزار",
    validFor: "١ ساڵ",
    installKey: "ChinaAcademy",
    tone: "orange",
    icon: Wrench,
  },
  {
    name: "پرۆفایلی دامەزراوەی پەروەردە",
    subtitle: "Apple School Manager",
    description: "تۆمارکردنی Apple School Manager بۆ iPad ـە بەڕێوەبراوەکان لە پۆل، تاقیگە، و پرۆگرامەکانی دامەزراوە.",
    category: "Education",
    issuer: "پەروەردە",
    installs: "٧٤ هەزار",
    validFor: "١ ساڵ",
    installKey: "ChinaPower",
    tone: "cyan",
    icon: GraduationCap,
    badge: "نوێ",
  },
  {
    name: "پرۆفایلی تۆڕی Wi-Fi",
    subtitle: "ڕێکخستنی تایبەت",
    description: "پرۆفایلی پێشوەختە ڕێکخراوی WPA2 لەگەڵ پشتڕاستکردنەوەی 802.1X بۆ دەستگەیشتنی Wi-Fi ـی کارگێڕی.",
    category: "Custom",
    issuer: "Wi-Fi",
    installs: "٦٢ هەزار",
    validFor: "هەمیشەیی",
    installKey: "Postal",
    tone: "cyan",
    icon: Wifi,
  },
  {
    name: "واژۆکردنی Enterprise ـی تایبەت",
    subtitle: "AppVault Signing",
    description: "کۆمەڵە بەڵگەنامەیەکی Enterprise ـی تەواو تایبەت واژۆکراو بۆ پێداویستییە تایبەتەکانی دامەزراوە.",
    category: "Enterprise",
    issuer: "واژۆی تایبەت",
    installs: "٣١ هەزار",
    validFor: "١ ساڵ",
    installKey: "Takeoff",
    tone: "violet",
    icon: FlaskConical,
  },
  {
    name: "جێگرەوەی TestFlight",
    subtitle: "AppVault Signing",
    description: "بەڵگەنامەی دابەشکردنی Ad-hoc بۆ تاقیکردنەوەی ئەپەکانی beta تا ١٠٠ ئامێری تۆمارکراو.",
    category: "Development",
    issuer: "تاقیکردنەوەی Beta",
    installs: "٢٨ هەزار",
    validFor: "٩٠ ڕۆژ",
    installKey: "Election",
    tone: "orange",
    icon: Zap,
    warning: true,
  },
];

const activeCategory = ref<Category>("All");
const query = ref("");

const filteredCertificates = computed(() => {
  const term = query.value.trim().toLowerCase();

  return certificates.filter((certificate) => {
    const matchesCategory = activeCategory.value === "All" || certificate.category === activeCategory.value;
    const searchable = [
      certificate.name,
      certificate.subtitle,
      certificate.description,
      certificate.category,
      categoryLabels[certificate.category],
      certificate.issuer,
    ]
      .join(" ")
      .toLowerCase();

    return matchesCategory && searchable.includes(term);
  });
});

const featuredCertificates = computed(() => certificates.filter((certificate) => certificate.featured));

const installUrl = (installKey: string) =>
  `itms-services://?action=download-manifest&url=https://raw.githubusercontent.com/FrizzleM/SideInstaller/main/output/sideinstaller-${installKey}.plist`;
</script>

<template>
  <div class="site-shell" lang="ckb" dir="rtl">
    <header class="topbar">
      <a class="brand" href="#" aria-label="ماڵەوەی CertVault">
        <span class="brand-mark">
          <ShieldCheck :size="17" />
        </span>
        <span dir="ltr">CertVault</span>
      </a>

      <label class="search-field" aria-label="گەڕان لە بەڵگەنامەکان">
        <Search :size="15" />
        <input v-model="query" type="search" placeholder="گەڕان لە بەڵگەنامەکان..." autocomplete="off" />
      </label>

      <span class="verified-pill">
        <BadgeCheck :size="14" />
        پرۆفایلە پشتڕاستکراوەکان
      </span>
    </header>

    <main class="page">
      <section class="hero" aria-labelledby="hero-title">
        <div class="eyebrow">
          <Smartphone :size="14" />
          دامەزرێنەری بەڵگەنامەی iOS
        </div>
        <h1 id="hero-title">
          بەڵگەنامەکان
          <span>لەسەر هەر iPhoneێک دابمەزرێنە.</span>
        </h1>
        <p>
          CertVault ئاسانترین ڕێگایە بۆ دامەزراندنی پرۆفایلەکانی ڕێکخستنی iOS،
          بەڵگەنامەکانی Enterprise، پرۆفایلەکانی MDM، و ڕێکخستنەکانی VPN ڕاستەوخۆ لە Safari.
        </p>

        <div class="hero-actions">
          <a class="primary-action" href="#certificates">
            گەڕان لە بەڵگەنامەکان
            <ChevronLeft :size="16" />
          </a>
          <a class="secondary-action" href="#how-it-works">
            چۆن کار دەکات
            <ChevronLeft :size="15" />
          </a>
        </div>
      </section>

      <section class="metrics" aria-label="ئاماری CertVault">
        <article>
          <strong>١٥٠+</strong>
          <span>بەڵگەنامەی بەردەست</span>
        </article>
        <article>
          <strong>٣.٢M</strong>
          <span>ئامێری تۆمارکراو</span>
        </article>
        <article>
          <strong>١٢-١٧</strong>
          <span>گونجاو لەگەڵ iOS</span>
        </article>
        <article>
          <strong>١٠٠٪</strong>
          <span>دەرکەرانی پشتڕاستکراوە</span>
        </article>
      </section>

      <section class="featured" aria-labelledby="featured-title">
        <h2 id="featured-title">بەڵگەنامە تایبەتەکان</h2>
        <div class="featured-grid">
          <article
            v-for="certificate in featuredCertificates"
            :key="certificate.name"
            class="featured-card"
            :class="`tone-${certificate.tone}`"
          >
            <div class="card-icon">
              <component :is="certificate.icon" :size="31" />
            </div>
            <div class="card-copy">
              <div class="card-kicker">
                بەڵگەنامەی تایبەت
                <span><BadgeCheck :size="11" /> پشتڕاستکراوە</span>
              </div>
              <h3>{{ certificate.name }}</h3>
              <p>{{ certificate.description }}</p>
              <div class="card-meta">
                <a class="small-install" :href="installUrl(certificate.installKey)">
                  <Download :size="13" />
                  دامەزراندنی پرۆفایل
                </a>
                <span>{{ certificate.validFor }}</span>
              </div>
            </div>
          </article>
        </div>
      </section>

      <section id="how-it-works" class="install-panel" aria-labelledby="steps-title">
        <h2 id="steps-title">چۆن بەڵگەنامە دابمەزرێنیت</h2>
        <div class="steps">
          <article>
            <span class="step-icon"><FileCheck2 :size="19" /></span>
            <span class="step-number">٠١</span>
            <h3>بەڵگەنامە هەڵبژێرە</h3>
            <p>کتێبخانەی پشتڕاستکراوەکان بگەڕێ و ئەو بەڵگەنامە یان پرۆفایلە هەڵبژێرە کە لەگەڵ پێداویستی دامەزراوە یان ئامێرەکەت دەگونجێت.</p>
          </article>
          <article>
            <span class="step-icon"><Download :size="19" /></span>
            <span class="step-number">٠٢</span>
            <h3>پرۆفایل دابەزێنە</h3>
            <p>دوگمەی دامەزراندن دابگرە و Safari فایلی mobileconfig ڕاستەوخۆ دادەبەزێنێت. هیچ ئەپی لاوەکی یان کۆمپیوتەرێک پێویست نییە.</p>
          </article>
          <article>
            <span class="step-icon"><CheckCircle2 :size="19" /></span>
            <span class="step-number">٠٣</span>
            <h3>لە Settings متمانە پێ بدە</h3>
            <p>بچۆ بۆ Settings، پرۆفایلی دابەزێنراو بکەرەوە، پاشان Trust بکە تا لەسەر ئامێرەکەت چالاک بێت.</p>
          </article>
        </div>
        <div class="settings-path" aria-label="ڕێڕەوی Settings">
          <span>ڕێڕەوی Settings:</span>
          <b dir="ltr">Settings</b>
          <b dir="ltr">General</b>
          <b dir="ltr">VPN &amp; Device Management</b>
          <b dir="ltr">Profile</b>
          <b dir="ltr">Trust</b>
        </div>
      </section>

      <section id="certificates" class="catalog" aria-labelledby="catalog-title">
        <div class="catalog-head">
          <h2 id="catalog-title">هەموو بەڵگەنامەکان</h2>
          <div class="filters" aria-label="پاڵاوتنی بەڵگەنامەکان">
            <button
              v-for="category in categories"
              :key="category"
              type="button"
              :class="{ active: activeCategory === category }"
              @click="activeCategory = category"
            >
              {{ categoryLabels[category] }}
            </button>
          </div>
        </div>

        <div class="certificate-grid">
          <article
            v-for="certificate in filteredCertificates"
            :key="certificate.name"
            class="certificate-card"
            :class="[`tone-${certificate.tone}`, { warning: certificate.warning }]"
          >
            <div class="cert-top">
              <span class="cert-icon">
                <component :is="certificate.icon" :size="24" />
              </span>
              <div>
                <h3>{{ certificate.name }}</h3>
                <p>{{ certificate.subtitle }}</p>
              </div>
              <span v-if="certificate.badge" class="mini-badge">{{ certificate.badge }}</span>
            </div>

            <p class="cert-description">{{ certificate.description }}</p>

            <div class="cert-details">
              <span>
                <Network :size="12" />
                {{ certificate.installs }} دامەزراندن
              </span>
              <span>
                <Settings :size="12" />
                {{ certificate.issuer }}
              </span>
            </div>

            <div class="cert-actions">
              <span class="trust-state" :class="{ warning: certificate.warning }">
                <BadgeCheck v-if="!certificate.warning" :size="12" />
                <Zap v-else :size="12" />
                {{ certificate.warning ? "پشتڕاستنەکراوە" : "پشتڕاستکراوە" }}
              </span>
              <span>{{ certificate.validFor }}</span>
              <a :href="installUrl(certificate.installKey)" aria-label="دامەزراندنی بەڵگەنامە">
                <Download :size="14" />
                دامەزراندن
              </a>
            </div>
          </article>
        </div>

        <p v-if="filteredCertificates.length === 0" class="empty-state">
          هیچ بەڵگەنامەیەک بەم گەڕانە نەدۆزرایەوە.
        </p>
      </section>
    </main>

    <footer class="footer">
      <div class="footer-rule"></div>
      <a class="footer-brand" href="#">
        <span class="brand-mark">
          <ShieldCheck :size="14" />
        </span>
        <span dir="ltr">CertVault</span>
      </a>
      <p>
        CertVault پەیوەندی بە Apple Inc. نییە. پێش دامەزراندنی پرۆفایلی ڕێکخستن کە زانیاری ئاسایشی ئامێر لەخۆ دەگرێت،
        هەمیشە سەرچاوەی بەڵگەنامەکان پشتڕاست بکەرەوە.
      </p>
      <nav aria-label="بەستەرەکانی پێپەڕە">
        <a href="#">تایبەتمەندی</a>
        <a href="#">مەرجەکان</a>
        <a href="#">ئاسایش</a>
        <a href="#">پەیوەندی</a>
      </nav>
    </footer>
  </div>
</template>

<style scoped>
@font-face {
  font-family: "Rabar";
  src: url("/fonts/Rabar_021.ttf") format("truetype");
  font-weight: 400 900;
  font-style: normal;
  font-display: swap;
}

:global(*) {
  box-sizing: border-box;
}

:global(html) {
  -webkit-text-size-adjust: 100%;
  scroll-behavior: smooth;
}

:global(body) {
  margin: 0;
  min-width: 320px;
  min-height: 100vh;
  color: #071b3a;
  background: #f3f7fe;
  direction: rtl;
  font-family: "Rabar", "Noto Naskh Arabic", "Segoe UI", Tahoma, Arial, sans-serif;
  line-height: 1.45;
}

:global(a) {
  color: inherit;
}

:global(button),
:global(input) {
  font: inherit;
}

.site-shell {
  min-height: 100vh;
}

.topbar {
  position: sticky;
  top: 0;
  z-index: 10;
  display: grid;
  grid-template-columns: 1fr minmax(260px, 440px) 1fr;
  align-items: center;
  gap: 24px;
  min-height: 48px;
  padding: 8px max(22px, calc((100vw - 1220px) / 2));
  background: rgba(248, 251, 255, 0.9);
  border-bottom: 1px solid #dbe7f7;
  backdrop-filter: blur(16px);
}

.brand,
.footer-brand {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  color: #071b3a;
  font-size: 14px;
  font-weight: 900;
  text-decoration: none;
}

.brand-mark {
  display: inline-grid;
  place-items: center;
  width: 24px;
  height: 24px;
  color: #ffffff;
  background: #176bff;
  border-radius: 50%;
  box-shadow: 0 8px 20px rgba(23, 107, 255, 0.22);
}

.search-field {
  position: relative;
  display: flex;
  align-items: center;
}

.search-field svg {
  position: absolute;
  inset-inline-start: 14px;
  color: #6c86ad;
  pointer-events: none;
}

.search-field input {
  width: 100%;
  height: 34px;
  padding: 0 40px 0 16px;
  color: #1b3760;
  background: #edf4fc;
  border: 1px solid #cfddec;
  border-radius: 999px;
  outline: 0;
}

.search-field input:focus {
  border-color: #176bff;
  box-shadow: 0 0 0 3px rgba(23, 107, 255, 0.12);
}

.search-field input::placeholder {
  color: #8ca1bd;
}

.verified-pill {
  justify-self: start;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  min-height: 29px;
  padding: 0 16px;
  color: #049557;
  background: #ecfff6;
  border: 1px solid #baf1d2;
  border-radius: 999px;
  font-size: 12px;
  font-weight: 900;
}

.page {
  width: min(100% - 48px, 1120px);
  margin: 0 auto;
  padding: 34px 0 0;
}

.hero {
  max-width: 720px;
  padding: 8px 0 36px;
}

.eyebrow {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  color: #176bff;
  font-size: 12px;
  font-weight: 900;
  letter-spacing: 0;
  text-transform: none;
}

.hero h1 {
  max-width: 620px;
  margin: 17px 0 0;
  color: #071b3a;
  font-size: clamp(44px, 6vw, 66px);
  line-height: 0.98;
  letter-spacing: 0;
}

.hero h1 span {
  display: block;
  color: #176bff;
}

.hero p {
  max-width: 680px;
  margin: 20px 0 0;
  color: #61718d;
  font-size: 16px;
}

.hero-actions {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 16px;
  margin-top: 30px;
}

.primary-action,
.secondary-action,
.small-install,
.cert-actions a {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 7px;
  text-decoration: none;
  white-space: nowrap;
}

.primary-action {
  min-height: 44px;
  padding: 0 24px;
  color: #ffffff;
  background: #176bff;
  border-radius: 999px;
  box-shadow: 0 10px 24px rgba(23, 107, 255, 0.22);
  font-size: 14px;
  font-weight: 900;
}

.secondary-action {
  color: #176bff;
  font-size: 14px;
  font-weight: 850;
}

.metrics {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 0;
  padding: 26px 0;
  border-top: 1px solid #cfddec;
  border-bottom: 1px solid #dbe7f7;
}

.metrics article {
  position: relative;
  min-height: 52px;
  padding-inline-start: 24px;
}

.metrics article::before {
  position: absolute;
  top: 7px;
  inset-inline-start: 2px;
  width: 8px;
  height: 8px;
  border: 2px solid #176bff;
  border-radius: 50%;
  content: "";
}

.metrics strong {
  display: block;
  color: #176bff;
  font-size: 29px;
  line-height: 1;
}

.metrics span {
  display: block;
  margin-top: 2px;
  color: #60718c;
  font-size: 12px;
  font-weight: 750;
}

.featured,
.catalog {
  padding-top: 34px;
}

.featured h2,
.catalog h2,
.install-panel h2 {
  margin: 0;
  color: #071b3a;
  font-size: 17px;
  font-weight: 950;
}

.featured-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 18px;
  margin-top: 16px;
}

.featured-card,
.certificate-card,
.install-panel {
  background: rgba(255, 255, 255, 0.86);
  border: 1px solid #d4e0ef;
  border-radius: 8px;
  box-shadow: 0 10px 24px rgba(24, 66, 119, 0.06);
}

.featured-card {
  position: relative;
  display: grid;
  grid-template-columns: 82px 1fr;
  gap: 21px;
  min-height: 196px;
  padding: 32px 28px;
  overflow: hidden;
}

.featured-card::after {
  position: absolute;
  top: -80px;
  inset-inline-end: -30px;
  width: 205px;
  height: 205px;
  background: var(--soft);
  border-radius: 50%;
  content: "";
}

.card-icon,
.cert-icon,
.step-icon {
  display: inline-grid;
  place-items: center;
  color: #ffffff;
  background: var(--accent);
}

.card-icon {
  align-self: center;
  width: 74px;
  height: 74px;
  border-radius: 8px;
  box-shadow: 0 14px 24px var(--shadow);
}

.card-copy {
  position: relative;
  z-index: 1;
  min-width: 0;
}

.card-kicker {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 8px;
  color: #176bff;
  font-size: 10px;
  font-weight: 950;
  letter-spacing: 0;
  text-transform: none;
}

.card-kicker span {
  display: inline-flex;
  align-items: center;
  gap: 3px;
  padding: 2px 6px;
  color: #049557;
  background: #ecfff6;
  border: 1px solid #baf1d2;
  border-radius: 999px;
  letter-spacing: 0;
  text-transform: none;
}

.featured-card h3,
.certificate-card h3,
.steps h3 {
  margin: 6px 0 0;
  color: #071b3a;
  line-height: 1.16;
}

.featured-card h3 {
  font-size: 19px;
}

.featured-card p,
.certificate-card p,
.steps p,
.footer p {
  color: #61718d;
}

.featured-card p {
  display: -webkit-box;
  margin: 9px 0 0;
  font-size: 13px;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.card-meta {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 14px;
  margin-top: 16px;
  color: #61718d;
  font-size: 12px;
  font-weight: 750;
}

.small-install {
  min-height: 29px;
  padding: 0 13px;
  color: #ffffff;
  background: #176bff;
  border-radius: 999px;
  font-size: 11px;
  font-weight: 900;
}

.install-panel {
  margin-top: 40px;
  padding: 34px;
  background: #edf6ff;
}

.steps {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 40px;
  margin-top: 26px;
}

.steps article {
  min-width: 0;
}

.step-icon {
  width: 34px;
  height: 34px;
  color: #176bff;
  background: #ffffff;
  border: 1px solid #bfd3ed;
  border-radius: 50%;
}

.step-number {
  display: inline-block;
  margin-inline-start: 7px;
  color: #8aa0bd;
  font-size: 12px;
  font-weight: 900;
}

.steps h3 {
  font-size: 14px;
}

.steps p {
  margin: 8px 0 0;
  font-size: 12px;
}

.settings-path {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 9px;
  margin-top: 28px;
  color: #61718d;
  font-size: 12px;
}

.settings-path b {
  min-height: 25px;
  padding: 5px 12px;
  color: #1f487d;
  background: #ffffff;
  border: 1px solid #bfd3ed;
  border-radius: 999px;
  font-size: 11px;
}

.catalog-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
  margin-bottom: 16px;
}

.filters {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-start;
  gap: 8px;
}

.filters button {
  min-height: 29px;
  padding: 0 13px;
  color: #526782;
  background: #ffffff;
  border: 1px solid #d4e0ef;
  border-radius: 999px;
  cursor: pointer;
  font-size: 11px;
  font-weight: 850;
}

.filters button.active {
  color: #ffffff;
  background: #176bff;
  border-color: #176bff;
}

.certificate-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 16px;
}

.certificate-card {
  display: flex;
  flex-direction: column;
  min-height: 220px;
  padding: 17px;
}

.cert-top {
  display: grid;
  grid-template-columns: 48px minmax(0, 1fr) auto;
  gap: 12px;
  align-items: start;
}

.cert-icon {
  width: 43px;
  height: 43px;
  border-radius: 8px;
}

.certificate-card h3 {
  display: -webkit-box;
  margin-top: 0;
  font-size: 14px;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.certificate-card .cert-top p {
  display: -webkit-box;
  margin: 4px 0 0;
  font-size: 11px;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.mini-badge {
  align-self: start;
  max-width: 92px;
  padding: 4px 8px;
  color: #176bff;
  background: #eef5ff;
  border: 1px solid #cfe0ff;
  border-radius: 999px;
  font-size: 9px;
  font-weight: 950;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.cert-description {
  display: -webkit-box;
  min-height: 42px;
  margin: 14px 0 0;
  font-size: 11px;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.cert-details {
  display: flex;
  flex-wrap: wrap;
  gap: 9px;
  margin-top: 12px;
  color: #7a8ca6;
  font-size: 10px;
  font-weight: 750;
}

.cert-details span {
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.cert-actions {
  display: grid;
  grid-template-columns: auto 1fr auto;
  align-items: center;
  gap: 8px;
  margin-top: auto;
  padding-top: 15px;
  color: #7a8ca6;
  font-size: 10px;
  font-weight: 850;
}

.trust-state {
  display: inline-flex;
  align-items: center;
  gap: 3px;
  min-width: 0;
  padding: 4px 8px;
  color: #049557;
  background: #ecfff6;
  border: 1px solid #baf1d2;
  border-radius: 999px;
}

.trust-state.warning {
  color: #b46a00;
  background: #fff8e6;
  border-color: #f3d99b;
}

.cert-actions a {
  min-height: 29px;
  padding: 0 12px;
  color: #ffffff;
  background: #176bff;
  border-radius: 999px;
  font-size: 10px;
  font-weight: 950;
}

.empty-state {
  margin: 24px 0 0;
  color: #61718d;
  text-align: center;
}

.footer {
  width: min(100% - 48px, 1120px);
  margin: 40px auto 0;
  padding: 0 0 42px;
  color: #61718d;
  text-align: center;
  font-size: 11px;
}

.footer-rule {
  height: 1px;
  margin-bottom: 26px;
  background: #d4e0ef;
}

.footer-brand {
  justify-content: center;
}

.footer .brand-mark {
  width: 22px;
  height: 22px;
}

.footer p {
  max-width: 520px;
  margin: 14px auto 0;
}

.footer nav {
  display: flex;
  justify-content: center;
  gap: 22px;
  margin-top: 16px;
}

.footer a {
  text-decoration: none;
}

.tone-blue {
  --accent: #176bff;
  --soft: #e8f1ff;
  --shadow: rgba(23, 107, 255, 0.22);
}

.tone-violet {
  --accent: #7048ff;
  --soft: #f2ecff;
  --shadow: rgba(112, 72, 255, 0.22);
}

.tone-green {
  --accent: #07a867;
  --soft: #e9fbf2;
  --shadow: rgba(7, 168, 103, 0.2);
}

.tone-orange {
  --accent: #ff7a22;
  --soft: #fff2e8;
  --shadow: rgba(255, 122, 34, 0.22);
}

.tone-cyan {
  --accent: #08b8dc;
  --soft: #e9faff;
  --shadow: rgba(8, 184, 220, 0.2);
}

@media (max-width: 860px) {
  .topbar {
    grid-template-columns: 1fr auto;
  }

  .search-field {
    grid-column: 1 / -1;
    grid-row: 2;
  }

  .page,
  .footer {
    width: min(100% - 32px, 1120px);
  }

  .metrics,
  .featured-grid,
  .steps,
  .certificate-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .catalog-head {
    align-items: flex-start;
    flex-direction: column;
  }

  .filters {
    justify-content: flex-start;
  }
}

@media (max-width: 560px) {
  .topbar {
    padding-inline: 15px;
  }

  .verified-pill {
    padding-inline: 10px;
    font-size: 10px;
  }

  .hero {
    padding-top: 14px;
  }

  .hero h1 {
    font-size: 42px;
  }

  .metrics,
  .featured-grid,
  .steps,
  .certificate-grid {
    grid-template-columns: 1fr;
  }

  .metrics {
    gap: 16px;
  }

  .featured-card {
    grid-template-columns: 62px 1fr;
    padding: 22px;
  }

  .card-icon {
    width: 56px;
    height: 56px;
  }

  .install-panel {
    padding: 22px;
  }

  .cert-top {
    grid-template-columns: 48px minmax(0, 1fr);
  }

  .mini-badge {
    grid-column: 2;
  }
}
</style>
