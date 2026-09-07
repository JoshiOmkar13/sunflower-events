/**
 * SUNFLOWER EVENTS LLP — Interactive Presentation Engine
 * Features:
 * - 25 Slide Architecture with smooth transitions
 * - Multi-Device Responsiveness (Mobile, Tablet, Laptop, Desktop)
 * - Touch Gestures: Horizontal Swipe Left/Right for Mobile & Tablet
 * - Keyboard Shortcuts: Arrows, Space, 'O' (Overview), 'B' (Language Mode), 'F' (Fullscreen)
 * - 3-Way Bilingual Switcher: Bilingual Dual-View / English Only / Marathi Only
 * - Slide Overview Grid Modal with dynamic thumbnail generation
 * - Video Player Modal with authentic case study playback
 * - Animated Number Counters on Achievements slide
 */

class SunflowerPresentationEngine {
    constructor() {
        this.slides = document.querySelectorAll('.slide');
        this.totalSlides = this.slides.length;
        this.currentSlide = 0;
        this.languageMode = 'both'; // 'both' | 'en' | 'mr'
        this.touchStartX = 0;
        this.touchStartY = 0;
        this.touchEndX = 0;
        this.touchEndY = 0;

        // Cache DOM Elements
        this.progressBar = document.getElementById('progressFill');
        this.counterCurrent = document.getElementById('navCurrent');
        this.counterTotal = document.getElementById('navTotal');
        this.prevBtn = document.getElementById('prevBtn');
        this.nextBtn = document.getElementById('nextBtn');
        this.gridModal = document.getElementById('gridModal');
        this.gridCloseBtn = document.getElementById('gridCloseBtn');
        this.gridContainer = document.getElementById('slidesOverviewGrid');
        this.gridTriggerBtn = document.getElementById('gridTriggerBtn');
        this.fullscreenBtn = document.getElementById('fullscreenBtn');

        // Video Modal Elements
        this.videoModal = document.getElementById('videoModal');
        this.videoCloseBtn = document.getElementById('videoCloseBtn');
        this.videoPlayer = document.getElementById('modalVideoPlayer');
        this.videoTitle = document.getElementById('modalVideoTitle');

        this.init();
    }

    init() {
        if (this.totalSlides === 0) return;

        // Set total slide indicator
        if (this.counterTotal) {
            this.counterTotal.textContent = String(this.totalSlides).padStart(2, '0');
        }

        // Initialize first slide
        this.showSlide(0);

        // Bind events
        this.bindKeyboardEvents();
        this.bindTouchEvents();
        this.bindNavButtons();
        this.bindLanguageSwitcher();
        this.bindModals();
        this.generateOverviewGrid();
        this.bindVideoCards();
    }

    showSlide(index) {
        if (index < 0 || index >= this.totalSlides) return;

        this.slides.forEach((slide, i) => {
            slide.classList.toggle('active', i === index);
            if (i === index) {
                slide.scrollTop = 0; // Reset scroll on slide change
            }
        });

        this.currentSlide = index;
        this.updateNavState();
        this.triggerSlideSpecificEffects(index);
    }

    nextSlide() {
        if (this.currentSlide < this.totalSlides - 1) {
            this.showSlide(this.currentSlide + 1);
        }
    }

    prevSlide() {
        if (this.currentSlide > 0) {
            this.showSlide(this.currentSlide - 1);
        }
    }

    updateNavState() {
        // Update Counter
        if (this.counterCurrent) {
            this.counterCurrent.textContent = String(this.currentSlide + 1).padStart(2, '0');
        }

        // Update Progress Bar
        if (this.progressBar) {
            const percentage = ((this.currentSlide + 1) / this.totalSlides) * 100;
            this.progressBar.style.width = `${percentage}%`;
        }

        // Update Buttons Disabled State
        if (this.prevBtn) this.prevBtn.disabled = (this.currentSlide === 0);
        if (this.nextBtn) this.nextBtn.disabled = (this.currentSlide === this.totalSlides - 1);

        // Update active thumbnail in grid
        const thumbs = document.querySelectorAll('.slide-thumbnail-card');
        thumbs.forEach((thumb, i) => {
            thumb.classList.toggle('active', i === this.currentSlide);
        });
    }

    bindKeyboardEvents() {
        document.addEventListener('keydown', (e) => {
            // Ignore if input or textarea is focused
            if (['INPUT', 'TEXTAREA'].includes(document.activeElement.tagName)) return;

            switch (e.key) {
                case 'ArrowRight':
                case 'ArrowDown':
                case ' ':
                case 'PageDown':
                    e.preventDefault();
                    this.nextSlide();
                    break;
                case 'ArrowLeft':
                case 'ArrowUp':
                case 'PageUp':
                case 'Backspace':
                    e.preventDefault();
                    this.prevSlide();
                    break;
                case 'Home':
                    e.preventDefault();
                    this.showSlide(0);
                    break;
                case 'End':
                    e.preventDefault();
                    this.showSlide(this.totalSlides - 1);
                    break;
                case 'o':
                case 'O':
                    e.preventDefault();
                    this.toggleGridModal();
                    break;
                case 'b':
                case 'B':
                    e.preventDefault();
                    this.cycleLanguageMode();
                    break;
                case 'f':
                case 'F':
                    e.preventDefault();
                    this.toggleFullscreen();
                    break;
                case 'Escape':
                    this.closeAllModals();
                    break;
            }
        });
    }

    bindTouchEvents() {
        const stage = document.querySelector('.presentation-stage') || document.body;

        stage.addEventListener('touchstart', (e) => {
            this.touchStartX = e.changedTouches[0].screenX;
            this.touchStartY = e.changedTouches[0].screenY;
        }, { passive: true });

        stage.addEventListener('touchend', (e) => {
            this.touchEndX = e.changedTouches[0].screenX;
            this.touchEndY = e.changedTouches[0].screenY;
            this.handleSwipeGesture();
        }, { passive: true });
    }

    handleSwipeGesture() {
        const deltaX = this.touchEndX - this.touchStartX;
        const deltaY = this.touchEndY - this.touchStartY;

        // Require minimum horizontal distance and ensure horizontal swipe > vertical swipe
        if (Math.abs(deltaX) > 45 && Math.abs(deltaX) > Math.abs(deltaY) * 1.5) {
            if (deltaX < 0) {
                // Swiped Left -> Go Next
                this.nextSlide();
            } else {
                // Swiped Right -> Go Prev
                this.prevSlide();
            }
        }
    }

    bindNavButtons() {
        if (this.prevBtn) {
            this.prevBtn.addEventListener('click', () => this.prevSlide());
        }
        if (this.nextBtn) {
            this.nextBtn.addEventListener('click', () => this.nextSlide());
        }

        // Progress bar click to jump
        const progressTrack = document.querySelector('.progress-track');
        if (progressTrack) {
            progressTrack.addEventListener('click', (e) => {
                const rect = progressTrack.getBoundingClientRect();
                const clickPos = (e.clientX - rect.left) / rect.width;
                const targetIndex = Math.min(this.totalSlides - 1, Math.max(0, Math.floor(clickPos * this.totalSlides)));
                this.showSlide(targetIndex);
            });
        }
    }

    bindLanguageSwitcher() {
        const buttons = document.querySelectorAll('.lang-btn');
        buttons.forEach(btn => {
            btn.addEventListener('click', () => {
                const mode = btn.getAttribute('data-mode');
                this.setLanguageMode(mode);
            });
        });
    }

    setLanguageMode(mode) {
        this.languageMode = mode;
        document.body.classList.remove('mode-both', 'mode-en', 'mode-mr');
        document.body.classList.add(`mode-${mode}`);

        const buttons = document.querySelectorAll('.lang-btn');
        buttons.forEach(btn => {
            btn.classList.toggle('active', btn.getAttribute('data-mode') === mode);
        });
    }

    cycleLanguageMode() {
        const modes = ['both', 'en', 'mr'];
        const nextIdx = (modes.indexOf(this.languageMode) + 1) % modes.length;
        this.setLanguageMode(modes[nextIdx]);
    }

    bindModals() {
        if (this.gridTriggerBtn) {
            this.gridTriggerBtn.addEventListener('click', () => this.toggleGridModal());
        }
        if (this.gridCloseBtn) {
            this.gridCloseBtn.addEventListener('click', () => this.closeGridModal());
        }
        if (this.gridModal) {
            this.gridModal.addEventListener('click', (e) => {
                if (e.target === this.gridModal) this.closeGridModal();
            });
        }

        if (this.videoCloseBtn) {
            this.videoCloseBtn.addEventListener('click', () => this.closeVideoModal());
        }
        if (this.videoModal) {
            this.videoModal.addEventListener('click', (e) => {
                if (e.target === this.videoModal) this.closeVideoModal();
            });
        }

        if (this.fullscreenBtn) {
            this.fullscreenBtn.addEventListener('click', () => this.toggleFullscreen());
        }
    }

    toggleGridModal() {
        if (!this.gridModal) return;
        const isActive = this.gridModal.classList.contains('active');
        if (isActive) {
            this.closeGridModal();
        } else {
            this.gridModal.classList.add('active');
        }
    }

    closeGridModal() {
        if (this.gridModal) this.gridModal.classList.remove('active');
    }

    generateOverviewGrid() {
        if (!this.gridContainer) return;
        this.gridContainer.innerHTML = '';

        this.slides.forEach((slide, index) => {
            const titleEn = slide.querySelector('.slide-title-en')?.textContent || `Slide ${index + 1}`;
            const titleMr = slide.querySelector('.slide-title-mr')?.textContent || '';

            const thumb = document.createElement('div');
            thumb.className = `slide-thumbnail-card ${index === this.currentSlide ? 'active' : ''}`;
            thumb.innerHTML = `
                <div class="thumb-num">SLIDE ${String(index + 1).padStart(2, '0')}</div>
                <div class="thumb-title">${titleEn}</div>
                <div class="thumb-sub">${titleMr}</div>
            `;

            thumb.addEventListener('click', () => {
                this.showSlide(index);
                this.closeGridModal();
            });

            this.gridContainer.appendChild(thumb);
        });
    }

    bindVideoCards() {
        const videoCards = document.querySelectorAll('.case-media-preview-card[data-video-src]');
        videoCards.forEach(card => {
            card.addEventListener('click', () => {
                const src = card.getAttribute('data-video-src');
                const title = card.getAttribute('data-video-title') || 'Sunflower Events Case Study';
                this.openVideoModal(src, title);
            });
        });
    }

    openVideoModal(src, title) {
        if (!this.videoModal || !this.videoPlayer) return;
        this.videoPlayer.src = src;
        if (this.videoTitle) this.videoTitle.textContent = title;
        this.videoModal.classList.add('active');
        this.videoPlayer.play().catch(() => {});
    }

    closeVideoModal() {
        if (!this.videoModal) return;
        if (this.videoPlayer) {
            this.videoPlayer.pause();
            this.videoPlayer.src = '';
        }
        this.videoModal.classList.remove('active');
    }

    closeAllModals() {
        this.closeGridModal();
        this.closeVideoModal();
    }

    toggleFullscreen() {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen().catch(() => {});
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            }
        }
    }

    triggerSlideSpecificEffects(index) {
        const slide = this.slides[index];
        if (!slide) return;

        // If Slide 22 (Metrics / Scale slide), animate counter numbers
        const counters = slide.querySelectorAll('.animate-counter');
        counters.forEach(counter => {
            const target = parseInt(counter.getAttribute('data-target'), 10);
            const prefix = counter.getAttribute('data-prefix') || '';
            const suffix = counter.getAttribute('data-suffix') || '';
            if (isNaN(target)) return;

            let count = 0;
            const step = Math.max(1, Math.ceil(target / 30));
            const interval = setInterval(() => {
                count += step;
                if (count >= target) {
                    counter.textContent = `${prefix}${target}${suffix}`;
                    clearInterval(interval);
                } else {
                    counter.textContent = `${prefix}${count}${suffix}`;
                }
            }, 30);
        });
    }
}

document.addEventListener('DOMContentLoaded', () => {
    window.sunflowerPresentation = new SunflowerPresentationEngine();
});
