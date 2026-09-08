# Sunflower Events LLP — Luxury Event Management Platform

> **End-to-End Event Strategy, Planning & Turnkey Execution**  
> Led by **Sayali Sahasrabudhe** | 18+ Years Business Leadership | 50+ Events Executed Since July 2023

---

## Live Deployments & Repository

| Target | URL |
|:-------|:----|
| **Production (SSL)** | https://sunflower-events.bjttvo.easypanel.host |
| **Direct VPS** | http://72.62.198.241:3086 |
| **Executive Deck** | https://sunflower-events.bjttvo.easypanel.host/deck.html |
| **Local Dev** | http://localhost:8080 |
| **GitHub** | https://github.com/JoshiOmkar13/sunflower-events |

---

## Tech Stack

| Layer | Technology |
|:------|:-----------|
| **Frontend** | Vanilla HTML5, CSS3, JavaScript (no framework dependencies) |
| **Design System** | Bottle Green (#1B4332) + Sunflower Gold (#D4A017), Inter font |
| **Local Server** | Node.js (HTTP range-streaming for MP4 videos) |
| **Container** | NGINX Alpine (Docker) |
| **Orchestration** | Docker Swarm (single node) |
| **Reverse Proxy & TLS** | Traefik + Let''s Encrypt |
| **Hosting** | Hostinger Cloud VPS (72.62.198.241) via Easypanel |

---

## Key Features

- **Luxury Responsive Website** — Full bottle green & sunflower gold design system, mobile-first
- **12-Slide Executive Deck** — Zero-scrollbar guarantee, keyboard/touch navigation, bilingual EN/मराठी
- **Authentic Gallery** — 12 high-resolution real ceremony photos from Odoo portfolio (1920px masters)
- **Real Case Study Videos** — 4 embedded MP4 case studies with range-streaming support
- **Artisanal Heritage Section** — 5 handcrafted ceremonial element cards with proper Marathi copy
- **Interactive Gallery Lightbox** — Click-to-enlarge with Escape-to-close
- **Founder Portrait** — Real cropped photograph of Sayali Sahasrabudhe integrated throughout
- **Privacy Masking** — Phone/email masked per P0 privacy policy, no redundant labels

---

## Quick Start

### Local Development

```powershell
cd E:\Clients\sunflower-events
powershell -File scripts\serve-local.ps1
# Opens http://localhost:8080
```

### Deploy to Production (Hostinger VPS)

```powershell
powershell -File scripts\deploy-hostinger.ps1
```

Requires `E:\Clients\dg-online\.env.local` with `HOSTINGER_SSH_PASSWORD`.

---

## Repository Structure

```
presentation/          <- Deployable web app (NGINX serves this directory)
  index.html           <- Main website
  deck.html            <- 12-slide executive deck
  website.css          <- Website design system
  presentation.css     <- Deck styling (zero-scrollbar)
  presentation.js      <- Deck engine (keyboard, touch, modals)
  Dockerfile           <- NGINX Alpine container
  assets/
    gallery/           <- 12 real ceremony photos (1920px)
    *.jpg / *.jpeg     <- Brand assets, founder portrait
    *.mp4              <- 4 case study videos

scripts/
  serve-local.js       <- Node.js range-streaming server
  serve-local.ps1      <- Local server launcher
  deploy-hostinger.ps1 <- Production deployment pipeline
  download-gallery.ps1 <- Re-fetch gallery from Odoo

docs/
  presentation-strategy-and-deck.md  <- Slide narrative & Marathi copy

openspec/
  presentation-spec.md               <- Technical specification

HANDOFF.md             <- Detailed developer handoff document
CLIENT_REQUIREMENTS_REGISTER.md <- Client scope & requirements
```

---

## For the Next Developer

See **[HANDOFF.md](HANDOFF.md)** for:
- Complete environment & SSH credentials reference
- Outstanding work items (what still needs to be done)
- Privacy rules and P0 constraints
- Git commit conventions
- Client contact details

---

*Built & deployed by AI Engineering Control Plane — meta-data-projects Application Factory*
