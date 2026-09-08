# Sunflower Events LLP — Corporate Presentation & Web Platform

> **End-to-End Event Strategy, Planning & Turnkey Execution**  
> Led by **Sayali Sahasrabudhe** (18+ Years Business Leadership | 50+ Events Executed Since July 2023)

---

## 🌐 Live Deployments & Repository
- **Production URL (SSL):** [https://sunflower-events.bjttvo.easypanel.host](https://sunflower-events.bjttvo.easypanel.host)
- **Direct VPS URL:** [http://72.62.198.241:3086](http://72.62.198.241:3086)
- **Local Development Server:** [http://localhost:8080](http://localhost:8080) (`/index.html` and `/deck.html`)
- **GitHub Repository:** [https://github.com/JoshiOmkar13/sunflower-events](https://github.com/JoshiOmkar13/sunflower-events)

---

## 📱 Architecture & Multi-Device Features
- **12-Slide Executive Architecture:** Exactly 12 focused slides condensing end-to-end strategic capabilities.
- **Strict Zero-Scrollbar Guarantee:** Engineered with `100dvh`, strict container constraints, and `min-height: 0` so no slide ever renders a vertical or horizontal scrollbar on any device.
- **Image + Diagrammatic Split-Screen:** Every slide features a high-definition photograph/visual on the left and a structured infographic diagram (process chevrons, quad cards, pillar matrices, timeline stacks) on the right.
- **Founder Identity:** Real cropped photograph of Founder Sayali Sahasrabudhe integrated on website and presentation deck.
- **Authentic Marathi & 'क्षण':** Culturally resonant Devanagari copy highlighting *अविस्मरणीय क्षण*, *मांगल्याचे क्षण*, and *सुवर्ण क्षण*.
- **3-Way Bilingual Switcher:** Toggle dynamically between *Dual View (EN + मराठी)*, *English Only*, and *मराठी Only*.
- **Embedded Media Hub:** Interactive video modal players with streaming support for verified client case studies (*Chi. Tanay 3,000 km, Chi. Advay Madhav Banquets, Chi. Aarin Vaze 23 Aug 2024*).
- **Navigation Controls:** Keyboard shortcuts (`←`, `→`, `Space`, `O` for 12-slide grid overview, `B` for language switcher, `F` for fullscreen) and mobile touch gestures.
- **Privacy Masked:** Contact numbers and emails masked per enterprise P0 privacy rules.

---

## 📂 Repository Structure
```text
├── clients-docs/             # Source brand photos & case study videos
├── docs/
│   └── presentation-strategy-and-deck.md  # Master strategic narrative & copy
├── presentation/
│   ├── assets/               # Production media assets (videos, photos, cropped founder portrait)
│   ├── index.html            # Luxury responsive corporate website
│   ├── deck.html             # 12-slide zero-scrollbar executive presentation deck
│   ├── website.css           # Website design system (bottle green & sunflower gold)
│   ├── presentation.css      # Presentation styling with strict zero-scrollbar rules
│   ├── presentation.js       # Presentation engine, gestures, modals & counters
│   └── Dockerfile            # High-performance NGINX Alpine container definition
├── scripts/
│   ├── serve-local.js        # Lightweight Node static server with MP4 range streaming
│   ├── serve-local.ps1       # Local server one-click launcher
│   └── deploy-hostinger.ps1  # Automated remote Hostinger VPS deployment pipeline
├── CLIENT_REQUIREMENTS_REGISTER.md
└── README.md
```
