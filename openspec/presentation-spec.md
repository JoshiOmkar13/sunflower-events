# OpenSpec: Presentation & UI/UX Architectural Standards

> **Specification ID:** `OS-PREZ-SUNFLOWER-001`  
> **Status:** APPROVED & ACTIVE  
> **Target:** Sunflower Events LLP Presentation Deck & Web Application  

---

## 1. Core Presentation Mandates (Non-Negotiable)

### 1.1 Zero-Scrollbar Guarantee
- **Strict Viewport Containment:** Every presentation slide MUST fit 100% within the standard screen height without triggering vertical or horizontal scrollbars (`overflow: hidden;`).
- **Responsive Sizing:** Typography, cards, and padding must utilize responsive clamps (`clamp()`, `vh`, `%`, `flex-shrink`) to scale gracefully on laptops (1366x768, 1440x900) without window maximization.

### 1.2 Diagram & Infographic-First Architecture
- **No Raw Document/Flyer Slapping:** Never embed raw marketing posters or print flyers directly onto presentation slides.
- **Conversion to Structured UI:** All concepts must be translated into native HTML/CSS/SVG visual diagrams:
  - Process Pipelines & Chevrons
  - Hierarchical Command Trees
  - Gantt Run-Sheet Timelines
  - Hexagonal / Card Metric Grids
  - Comparison Matrices
- **Minimal Concise Copy:** Avoid large prose paragraphs. Use high-impact headlines, 2-line supporting subtitles, and bulleted tags.

### 1.3 Strict Bilingual Marathi Standard ('क्षण' Rule)
- **Cultural Accuracy:** Use proper, refined, authentic Marathi (सुसंस्कृत, नेमके आणि उच्च दर्जाचे मराठी).
- **Mandatory 'क्षण' Concept:** When describing moments, celebrations, and emotional experiences, employ 'क्षण' appropriately:
  - *"अविस्मरणीय क्षण"* (Unforgettable Moments)
  - *"आनंदाचे आणि मांगल्याचे क्षण"* (Joyous & Sacred Moments)
  - *"प्रत्येक क्षण परिपूर्ण"* (Every Moment Perfected)
- **Fallback Rule:** If any concept cannot be translated naturally without awkward literal phrasing, retain clean professional English.

### 1.4 Visual Palette: Deep Olive & Bottle Green
- **Dominant Base:** Deep Obsidian Olive (`#0d1a12`, `#13261a`).
- **Surface Cards:** Rich Bottle Green (`#1a3324`, `#22422f`).
- **Accent:** Warm Radiant Sunflower Amber (`#e5a93c`, `#f5b74c`).
- **Text & Accents:** Champagne Ivory (`#f7f5ee`) and Soft Sage (`#a3b899`).

### 1.5 Privacy & Contact Data Policy
- **Phone Number:** `9920431983` (Official business contact).
- **Email:** Masked (`c********@sunflowerevents.com` or `contact@sunflowerevents.in`).
- **Socials:** `@sunflowerevents_in_mumbai` (Instagram official handle).
