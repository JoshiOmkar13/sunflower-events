# Sunflower Events LLP — Client Requirements Register

> **Client ID:** `sunflower-events`  
> **Client Legal Entity:** Sunflower Events LLP  
> **Founder & Lead Strategist:** Sayali Sahasrabudhe  
> **Direct Line / WhatsApp:** +91 99204 ..... (Masked per P0 Privacy Policy)  
> **Official Email:** `c********@sunflowerevents.com` (Masked)  
> **Socials:** `@sunflowerevents_in_mumbai` (Instagram) | `Sunflower events by Sayali S` (Facebook)  
> **Primary Vertical:** Event Strategy & Turnkey Event Management (Weddings, Upanayan/Bratabandha, Milestone Birthdays, Corporate)  
> **Isolation Tier:** Dedicated Child Repository (`E:\Clients\sunflower-events`)  
> **GitHub Remote:** `https://github.com/JoshiOmkar13/sunflower-events`  
> **Live Production URL:** `https://sunflower-events.bjttvo.easypanel.host`  
> **Direct VPS URL:** `http://72.62.198.241:3086`  
> **Local Server URL:** `http://localhost:8080` (Website: `/index.html`, Deck: `/deck.html`)

---

## 1. Verified Core Capabilities & Statistics

- **18+ Years** Proven Business & Management Leadership (Founder Sayali Sahasrabudhe founded and scaled *Everything For Her*).
- **50+ Milestone Events** Executed successfully since July 2023 with 100% 5-star host feedback.
- **100% End-to-End Turnkey Coordination** (Venue, Vedic Rituals, Acoustics, Hospitality, Catering, Logistics).
- **3,000+ Kilometres** Remote Planning Distance Mastered for overseas/NRI clients.

---

## 2. Scope of Deliverables

| Deliverable | Location / Endpoint | Status |
| :--- | :--- | :--- |
| **Responsive Luxury Website (Bottle Green & Gold)** | `presentation/index.html` | Completed & Live |
| **Gallery Section with Lightbox** | `presentation/index.html#gallery` | Completed (12 authentic Odoo assets) |
| **Artisanal Heritage Section** | `presentation/index.html#craft` | Completed (presentable titles & badges) |
| **Founder Sayali Madam Cropped Photo** | `presentation/assets/sunflower-events-founder-sayali.jpg` | Completed & Integrated |
| **Hero Grand Venue Stage Photo** | `assets/gallery/gallery-venue-grand-stage.jpg` | Completed (1920x1280 real venue photo) |
| **Privacy: Removed "(Protected / Masked)" Labels** | All website & deck files | Completed |
| **Privacy: Phone/Email Masking** | `+91 99204 .....` / `c********@` | Completed |
| **Artisanal Details Nav (renamed from Micro-Craft)** | Top nav `#craft` | Completed |
| **Website CSS Design System** | `presentation/website.css` | Completed |
| **12-Slide Zero-Scrollbar Presentation Deck** | `presentation/deck.html` | PARTIAL — Rework Requested |
| **Presentation CSS (Zero-Scrollbar)** | `presentation/presentation.css` | Completed |
| **Presentation Engine (Keyboard, Touch, Modals)** | `presentation/presentation.js` | Completed |
| **Case Study Videos (4 MP4s)** | `presentation/assets/*.mp4` | Completed |
| **Local Streaming Server (Node.js)** | `scripts/serve-local.js` | Live at `http://localhost:8080/` |
| **Production Docker Container** | `presentation/Dockerfile` (NGINX Alpine) | Completed |
| **Hostinger VPS Deployment** | `https://sunflower-events.bjttvo.easypanel.host` | Live & Verified (200 OK) |
| **GitHub Repository** | `https://github.com/JoshiOmkar13/sunflower-events` | Pushed (main, commit 7235529) |

---

## 3. Pending / Requested Changes

### 3.1 PRESENTATION DECK REWORK (HIGH PRIORITY — Client Explicitly Requested)

**Date Requested:** September 8, 2026  
**Client Feedback:** "The presentation is not good. Photos are big, text is unstructured. You have to use proper squares and boxes to show everything. It should be a world-class presentation."

**Requirement:**
- Redesign `presentation/deck.html` to match the quality/structure of the Milind Ambekar presentation
- Reference: `E:\Clients\milind-ambekar\presentation\index.html` and `presentation.css`
- Every slide must use structured boxes, cards, grids, and infographic diagrams
- Photos should be smaller, framed, not dominating the full slide column
- Use diag-card, diag-grid-2, diag-grid-3, soothing-callout, diag-icon-box patterns
- Maintain: 12 slides, zero scrollbar, split-screen layout, keyboard/touch navigation
- After rework: rebuild Docker image and re-deploy to Hostinger VPS

### 3.2 CONTACT FORM BACKEND
- Current form has no action — submissions are lost
- Hook to n8n webhook or Formspree

### 3.3 WHATSAPP FLOATING WIDGET
- Add floating bottom-right WhatsApp button (wa.me link)

### 3.4 SEO
- Add meta description, Open Graph tags, JSON-LD LocalBusiness schema

---

## 4. Key Case Studies Cataloged

1. **Chi. Tanay''s Remote Upanayan (3,000 km Away):** Successfully coordinated for an overseas family from USA; live rangoli, custom rukhwat, glowing testimonials from host Prabhat.
2. **Chi. Advay''s Cultural Soiree at Madhav Banquets:** Live traditional Sugam Sangeet vocalists, harmonium, tabla, live floor portrait art, floral umbrella entry.
3. **Chi. Aarin Vaze''s Bratabandha (23 August 2024):** 6-panel educational Antarpat, 9 blessing placards (Shatayu Bhava, Yashwant Ho), royal marigold Palkhi procession, Matribhojan easel artboards, wooden engraved lapel pins.

---

## 5. P0 Privacy Rules (Non-Negotiable)

- Phone number: ALWAYS display as `+91 99204 .....` — never reveal digits
- Email: ALWAYS display as `c********@sunflowerevents.com` — never reveal address
- NEVER print the words "(Protected / Masked)" or "(Masked)" in any user-facing text
- Actual credentials stored ONLY in `E:\Clients\dg-online\.env.local` — NOT in this repo
