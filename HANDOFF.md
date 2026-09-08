# Sunflower Events LLP — Developer Handoff Document

> **Client:** Sunflower Events LLP  
> **Founder:** Sayali Sahasrabudhe  
> **Handoff Date:** September 2026  
> **Prepared by:** AI Engineering Control Plane (`meta-data-projects`)  
> **Status:** Production Live — Ready for Next Developer

---

## Quick Reference (Everything You Need)

| Item | Value |
|:-----|:------|
| **Live Production URL (SSL)** | https://sunflower-events.bjttvo.easypanel.host |
| **Direct VPS URL** | http://72.62.198.241:3086 |
| **Local Dev Server** | http://localhost:8080 |
| **GitHub Repository** | https://github.com/JoshiOmkar13/sunflower-events |
| **Local Repo Path** | `E:\Clients\sunflower-events` |
| **VPS Host** | Hostinger Cloud VPS — 72.62.198.241 |
| **VPS SSH User** | root |
| **VPS SSH Password** | Stored in `E:\Clients\dg-online\.env.local` key: HOSTINGER_SSH_PASSWORD |
| **Container Orchestration** | Docker Swarm (easypanel network) |
| **Container Port** | 3086 (host) to 80 (container) |
| **TLS / HTTPS** | Traefik + Let''s Encrypt (auto-renews) |
| **Presentation Deck** | https://sunflower-events.bjttvo.easypanel.host/deck.html |
| **Git Branch** | main |
| **Last Commit** | 7235529 |

---

## Repository Structure

```
sunflower-events/
├── HANDOFF.md                           <- You are here
├── README.md                            <- Architecture overview
├── CLIENT_REQUIREMENTS_REGISTER.md     <- Client requirements, scope, case studies
|
├── clients-docs/                        <- Source brand assets (photos, logos, videos from client)
|
├── docs/
|   └── presentation-strategy-and-deck.md   <- Full 12-slide narrative, Marathi copy, strategy
|
├── openspec/
|   └── presentation-spec.md             <- Technical spec for deck & website
|
├── presentation/                        <- THE ENTIRE DEPLOYABLE WEB APP (served by NGINX)
|   ├── index.html                       <- Main luxury website
|   ├── deck.html                        <- 12-slide executive presentation deck
|   ├── website.css                      <- Website design system (bottle green + sunflower gold)
|   ├── presentation.css                 <- Presentation CSS (zero-scrollbar constraints)
|   ├── presentation.js                  <- Presentation engine (keyboard, swipe, modal, counter)
|   ├── Dockerfile                       <- NGINX Alpine container
|   └── assets/
|       ├── gallery/                     <- 12 authentic Odoo gallery photos (1920px masters)
|       |   ├── gallery-venue-grand-stage.jpg       <- HERO photo (1920x1280)
|       |   ├── gallery-venue-floral-mandap.jpg
|       |   ├── gallery-venue-grand-hall.jpg
|       |   ├── gallery-munj-rangoli.jpg
|       |   ├── gallery-vratabandha-ceremony.jpg
|       |   ├── gallery-ceremonial-palkhi.jpg
|       |   ├── gallery-custom-name-board.jpg
|       |   ├── gallery-floral-entry-umbrella.jpg
|       |   ├── gallery-venue-banquet-decor.jpg
|       |   ├── gallery-venue-banquet-hall.jpg
|       |   ├── gallery-venue-lighting-setup.jpg
|       |   └── gallery-venue-stage-decor.jpg
|       ├── sunflower-events-founder-sayali.jpg          <- Cropped portrait of Sayali Madam
|       ├── sunflower-events-founder-sayali-original.jpg <- Uncropped original
|       ├── sunflower-events-official-brand-logo.jpeg
|       └── *.mp4   <- 4 case study videos (range-streamed by local server)
|
└── scripts/
    ├── serve-local.js                   <- Node.js static server with MP4 range-streaming
    ├── serve-local.ps1                  <- One-click local server launcher (PowerShell)
    ├── deploy-hostinger.ps1             <- Full VPS deployment automation (PowerShell)
    └── download-gallery.ps1            <- Re-downloads gallery images from Odoo if needed
```

---

## Local Development Setup

### Prerequisites
- Node.js (any recent LTS)
- Git
- PowerShell (Windows)

### Start Local Server

```powershell
cd E:\Clients\sunflower-events
powershell -File scripts\serve-local.ps1
```

Server starts at http://localhost:8080. URLs:
- Website: http://localhost:8080/index.html
- Presentation Deck: http://localhost:8080/deck.html

> IMPORTANT: The local server includes HTTP range-request support for .mp4 videos.
> Do NOT replace with plain Python http.server — it does not support range headers.

---

## Production Deployment

### Full Automated Deployment to Hostinger VPS

```powershell
cd E:\Clients\sunflower-events
powershell -File scripts\deploy-hostinger.ps1
```

What this script does (fully automated):
1. Reads SSH credentials from E:\Clients\dg-online\.env.local
2. Creates a timestamped .tar.gz release archive of presentation/
3. Streams the archive to the VPS over SSH
4. On VPS: extracts archive, runs docker build, deploys/updates Docker Swarm service
5. Writes Traefik YAML config for HTTPS routing via Let''s Encrypt
6. Probes localhost:3086 on VPS and prints HTTP status

### SSH Credentials Location

```
File: E:\Clients\dg-online\.env.local
Keys:
  HOSTINGER_SSH_USER=root
  HOSTINGER_SSH_PASSWORD=<password>
```

### Docker Architecture on VPS

```
Docker Swarm (single node)
  Service: sunflower-events
    Image: sunflower-events:latest  (NGINX Alpine)
      Files: /usr/share/nginx/html/ (entire presentation/ folder)
```

Traefik routes sunflower-events.bjttvo.easypanel.host to container port 80 with Let''s Encrypt TLS.

### Useful VPS Commands (after SSH in)

```bash
docker service ls
docker service ps sunflower-events
docker logs $(docker ps -q --filter name=sunflower-events) --tail 50
```

---

## Website Architecture (index.html)

### Design System
- Primary Color: Bottle Green (#1B4332 / #2D6A4F / #40916C)
- Accent: Sunflower Gold (#D4A017)
- Font: Inter (Google Fonts CDN)
- Layout: Responsive CSS Grid, Flexbox

### Navigation Sections

| Nav Label | Anchor | Description |
|:----------|:-------|:------------|
| Home | #home | Hero viewport with Grand Venue Stage photo |
| Our Services | #services | 4 service cards (Weddings, Milestones, Corporate, Upanayan) |
| Artisanal Details | #craft | 5 handcrafted ceremonial element cards |
| Real Celebrations | #testimonials | 3 case study cards with embedded video modals |
| Gallery | #gallery | 12-photo interactive CSS grid with lightbox |
| Meet the Founder | #founder | Sayali Madam cropped portrait + bio |
| Contact | #contact | WhatsApp CTA + contact form |

### Privacy Rules (P0 — Non-Negotiable)
- Phone: displays as +91 99204 ....  — NEVER reveal actual number
- Email: displays as c********@sunflowerevents.com — NEVER reveal actual address
- NEVER add the text "(Protected / Masked)" or "(Masked)" — these are redundant and unprofessional

---

## Presentation Deck Architecture (deck.html)

### Principles
- 12 Slides Exactly — do not add more (client requirement)
- Zero Scrollbar Guarantee — every slide uses 100dvh height constraints
- Split-Screen Layout — LEFT = photograph/image, RIGHT = structured diagram/infographic

### Slide Map

| # | Title | Diagram Type |
|:--|:------|:------------|
| 01 | Brand Identity & Philosophy | Founder quote + 3 pillars |
| 02 | The Sunflower Events Difference | 4-column service overview |
| 03 | Weddings & Sacred Union | 6-step ceremony timeline |
| 04 | Upanayan / Bratabandha | 5-panel ritual grid |
| 05 | Milestone Birthdays & Sangeet | Feature matrix |
| 06 | Corporate Events | 4-column deliverables |
| 07 | Remote Planning for NRI Families | 3-stage process flow |
| 08 | Artisanal Heritage | 5-element grid |
| 09 | Real Celebrations Gallery | 4-photo mosaic |
| 10 | Case Study — Chi. Tanay (3,000 km) | Metrics + video CTA |
| 11 | Founder Identity — Sayali Sahasrabudhe | Bio + credentials |
| 12 | Connect & Begin Your Journey | Contact gateway |

### Keyboard Controls

| Key | Action |
|:----|:-------|
| Right Arrow / Space | Next slide |
| Left Arrow | Previous slide |
| O | Toggle 12-slide grid overview |
| B | Toggle bilingual mode |
| F | Toggle fullscreen |
| Swipe Left/Right | Next/Previous (mobile) |

---

## Outstanding Work — Next Developer TODO

### HIGH PRIORITY (Client Requested)

1. PRESENTATION DECK REWORK (deck.html)
   The client has requested a complete redesign of the presentation deck.
   Current issue: Large photos dominate slides, text is unstructured.

   Requirements for the rework:
   - Use proper structured boxes, cards, grids, and infographic diagrams on every slide
   - Match the component patterns from the Milind Ambekar deck:
     Reference: E:\Clients\milind-ambekar\presentation\index.html
     Key CSS classes to reuse/adapt: diag-card, diag-grid-2, diag-grid-3,
     soothing-callout, diag-icon-box, slide-tag, slide-header
   - Keep 12 slides, zero scrollbar guarantee, split-screen layout
   - Photos should be smaller, framed, not dominating the full column
   - Every slide needs a visual LEFT and structured diagram/infographic RIGHT

### MEDIUM PRIORITY

2. CUSTOM DOMAIN
   Currently on bjttvo.easypanel.host subdomain.
   Client may want sunflowerevents.com or similar custom domain.
   Steps: Point domain DNS A record to 72.62.198.241, update Traefik config.

3. WHATSAPP CHAT WIDGET
   Add floating WhatsApp icon bottom-right.
   URL format: https://wa.me/91992XXXXXX

4. SEO META TAGS
   Add <meta name="description">, Open Graph tags, and JSON-LD LocalBusiness schema.

5. CONTACT FORM BACKEND
   Current "Send Inquiry" form has no backend.
   Hook to n8n webhook or Formspree to deliver submissions to Sayali Madam.

### NICE TO HAVE

6. More gallery photos from Instagram @sunflowerevents_in_mumbai
7. Auto-play testimonials carousel

---

## Re-downloading Gallery Images

If gallery images need to be re-fetched from the client''s Odoo portal:

```powershell
powershell -File scripts\download-gallery.ps1
```

Source: https://sunflowerevents3.odoo.com/gallery

---

## Git Commit Convention

Use Conventional Commits format:

```
feat(gallery): add new ceremony photos from Instagram
fix(deck): resolve scrollbar on slide 07 at 1366px width
chore(assets): compress gallery images for faster load
docs(handoff): update outstanding work items
style(website): adjust bottle green shade for better contrast
```

---

## Client Contact (for Reference)

- Founder: Sayali Sahasrabudhe
- WhatsApp: +91 99204 ..... (actual number in .env.local)
- Instagram: https://www.instagram.com/sunflowerevents_in_mumbai/
- Facebook: Sunflower events by Sayali S
- Odoo Gallery: https://sunflowerevents3.odoo.com/gallery
- Odoo Portfolio: https://sunflowerevents3.odoo.com

---

*Handoff prepared by AI Engineering Control Plane — meta-data-projects v3.0*
