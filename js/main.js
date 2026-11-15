(() => {
  const menuButton = document.querySelector("[data-menu-toggle]");
  const navigation = document.querySelector("[data-nav]");

  if (menuButton && navigation) {
    menuButton.addEventListener("click", () => {
      const isOpen = navigation.classList.toggle("is-open");
      menuButton.setAttribute("aria-expanded", String(isOpen));
      menuButton.querySelector(".sr-only").textContent = isOpen ? "Close navigation" : "Open navigation";
    });

    navigation.addEventListener("click", (event) => {
      if (event.target.closest("a")) {
        navigation.classList.remove("is-open");
        menuButton.setAttribute("aria-expanded", "false");
      }
    });
  }

  document.querySelectorAll("[data-copy-button]").forEach((button) => {
    button.addEventListener("click", async () => {
      const text = button.closest(".copy-block")?.querySelector("[data-copy-text]")?.textContent.trim();
      if (!text) return;

      try {
        await navigator.clipboard.writeText(text);
        const previous = button.textContent;
        button.textContent = "Copied";
        window.setTimeout(() => { button.textContent = previous; }, 1600);
      } catch {
        button.textContent = "Select text to copy";
      }
    });
  });

  const galleryButtons = Array.from(document.querySelectorAll("[data-gallery-index]"));
  const lightbox = document.querySelector("[data-lightbox]");
  const lightboxImage = lightbox?.querySelector("[data-lightbox-image]");
  const lightboxCaption = lightbox?.querySelector("[data-lightbox-caption]");
  const lightboxDownload = lightbox?.querySelector("[data-lightbox-download]");
  const lightboxCounter = lightbox?.querySelector("[data-lightbox-counter]");
  let activeGalleryIndex = 0;
  let lightboxTrigger = null;
  let lightboxHistoryActive = false;

  const showGalleryImage = (index) => {
    if (!lightbox || !lightboxImage || !lightboxCaption || !lightboxDownload || galleryButtons.length === 0) return;

    activeGalleryIndex = (index + galleryButtons.length) % galleryButtons.length;
    const button = galleryButtons[activeGalleryIndex];
    const thumbnail = button.querySelector("img");
    const source = button.dataset.full;

    lightboxImage.src = source;
    lightboxImage.alt = thumbnail?.alt || "The Cradle of Life screenshot";
    lightboxCaption.textContent = button.dataset.caption || "The Cradle of Life screenshot";
    lightboxDownload.href = source;
    if (lightboxCounter) lightboxCounter.textContent = `${activeGalleryIndex + 1} / ${galleryButtons.length}`;

    if (lightboxHistoryActive && history.state?.cradleLightbox) {
      history.replaceState(history.state, "", `${location.pathname}${location.search}#screenshot-${activeGalleryIndex + 1}`);
    }
  };

  const restoreGalleryFocus = () => {
    const trigger = lightboxTrigger;
    lightboxTrigger = null;
    window.requestAnimationFrame(() => trigger?.focus({ preventScroll: true }));
  };

  const closeLightbox = ({ fromHistory = false } = {}) => {
    if (lightbox?.hasAttribute("open")) {
      if (!lightbox.classList.contains("lightbox-fallback") && typeof lightbox.close === "function") {
        lightbox.close();
      } else {
        lightbox.removeAttribute("open");
      }
    }
    lightbox?.classList.remove("lightbox-fallback");
    document.body.classList.remove("lightbox-open");

    if (!fromHistory && lightboxHistoryActive && history.state?.cradleLightbox) {
      lightboxHistoryActive = false;
      restoreGalleryFocus();
      history.back();
    } else {
      lightboxHistoryActive = false;
      restoreGalleryFocus();
    }
  };

  galleryButtons.forEach((button, index) => {
    button.addEventListener("click", () => {
      if (!lightbox) return;

      lightboxTrigger = button;
      showGalleryImage(index);
      if (typeof lightbox.showModal === "function") {
        lightbox.showModal();
      } else {
        lightbox.classList.add("lightbox-fallback");
        lightbox.setAttribute("open", "");
      }
      document.body.classList.add("lightbox-open");
      history.pushState({ ...(history.state || {}), cradleLightbox: true }, "", `${location.pathname}${location.search}#screenshot-${index + 1}`);
      lightboxHistoryActive = true;
      lightbox.querySelector("[data-lightbox-close]")?.focus({ preventScroll: true });
    });
  });

  lightbox?.querySelector("[data-lightbox-close]")?.addEventListener("click", () => closeLightbox());
  lightbox?.querySelector("[data-lightbox-prev]")?.addEventListener("click", () => showGalleryImage(activeGalleryIndex - 1));
  lightbox?.querySelector("[data-lightbox-next]")?.addEventListener("click", () => showGalleryImage(activeGalleryIndex + 1));

  lightbox?.addEventListener("click", (event) => {
    if (event.target === lightbox) closeLightbox();
  });

  lightbox?.addEventListener("cancel", (event) => {
    event.preventDefault();
    closeLightbox();
  });

  lightbox?.addEventListener("keydown", (event) => {
    if (event.key === "ArrowLeft") showGalleryImage(activeGalleryIndex - 1);
    if (event.key === "ArrowRight") showGalleryImage(activeGalleryIndex + 1);
  });

  window.addEventListener("popstate", () => {
    if (lightbox?.hasAttribute("open")) closeLightbox({ fromHistory: true });
  });

  const resourceExists = async (path) => {
    if (!path || typeof path !== "string") return false;

    try {
      const response = await fetch(path, { method: "HEAD", cache: "no-store" });
      return response.ok;
    } catch {
      return false;
    }
  };

  const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)");

  const story = document.querySelector("[data-story]");
  const storyPanels = Array.from(document.querySelectorAll("[data-story-panel]"));
  const storyVisuals = Array.from(document.querySelectorAll("[data-story-visual]"));
  const storySteps = Array.from(document.querySelectorAll("[data-story-step]"));
  const storyJumps = Array.from(document.querySelectorAll("[data-story-jump]"));
  const storyScrollCue = document.querySelector(".story-scroll-cue");
  let activeStoryStage = 0;

  const setStoryStage = (stage) => {
    const nextStage = Math.max(0, Math.min(stage, storyPanels.length - 1));
    activeStoryStage = nextStage;
    if (story) story.dataset.storyStage = String(nextStage);

    storyPanels.forEach((panel, index) => {
      const isActive = index === nextStage;
      panel.classList.toggle("is-active", isActive);
      panel.setAttribute("aria-hidden", String(!isActive));
    });

    storyVisuals.forEach((visual, index) => {
      const isActive = index === nextStage;
      visual.classList.toggle("is-active", isActive);
      if (visual instanceof HTMLVideoElement) {
        if (isActive && !reducedMotion.matches && !document.hidden) {
          visual.play().catch(() => {});
        } else {
          visual.pause();
        }
      }
    });

    storyJumps.forEach((button, index) => {
      const isActive = index === nextStage;
      button.classList.toggle("is-active", isActive);
      button.setAttribute("aria-current", isActive ? "step" : "false");
    });

    storyScrollCue?.classList.toggle("is-hidden", nextStage !== 0);
  };

  if (story && storySteps.length > 0 && !reducedMotion.matches) {
    if ("IntersectionObserver" in window) {
      const storyObserver = new IntersectionObserver((entries) => {
        const visibleStep = entries
          .filter((entry) => entry.isIntersecting)
          .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];
        if (visibleStep) setStoryStage(Number(visibleStep.target.dataset.storyStep));
      }, { rootMargin: "-42% 0px -42% 0px", threshold: [0, 0.1, 0.5] });

      storySteps.forEach((step) => storyObserver.observe(step));
    } else {
      const updateStoryFromScroll = () => {
        const bounds = story.getBoundingClientRect();
        const progress = Math.max(0, Math.min(0.999, -bounds.top / Math.max(1, bounds.height - window.innerHeight)));
        setStoryStage(Math.floor(progress * storySteps.length));
      };
      window.addEventListener("scroll", updateStoryFromScroll, { passive: true });
      updateStoryFromScroll();
    }
  }

  storyJumps.forEach((button) => {
    button.addEventListener("click", () => {
      const stage = Number(button.dataset.storyJump);
      const step = storySteps[stage];
      if (!step) return;
      const destination = window.scrollY + step.getBoundingClientRect().top + (step.offsetHeight / 2) - (window.innerHeight / 2);
      window.scrollTo({ top: destination, behavior: reducedMotion.matches ? "auto" : "smooth" });
    });
  });

  document.addEventListener("visibilitychange", () => {
    const activeVisual = storyVisuals[activeStoryStage];
    if (!(activeVisual instanceof HTMLVideoElement)) return;
    if (document.hidden || reducedMotion.matches) activeVisual.pause();
    else activeVisual.play().catch(() => {});
  });

  const galleryToggle = document.querySelector("[data-gallery-toggle]");
  const secondaryGalleryItems = Array.from(document.querySelectorAll(".gallery-item-secondary"));

  galleryToggle?.addEventListener("click", () => {
    const isExpanded = galleryToggle.getAttribute("aria-expanded") === "true";
    secondaryGalleryItems.forEach((item) => { item.hidden = isExpanded; });
    galleryToggle.setAttribute("aria-expanded", String(!isExpanded));
    galleryToggle.textContent = isExpanded ? "View all 12 screenshots" : "Show six featured screenshots";

    if (isExpanded) {
      document.querySelector("#screenshots")?.scrollIntoView({ behavior: reducedMotion.matches ? "auto" : "smooth" });
    }
  });

  setStoryStage(0);

  const playbackObserver = "IntersectionObserver" in window
    ? new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
          const video = entry.target;
          if (entry.isIntersecting && !reducedMotion.matches) {
            video.play().catch(() => {});
          } else {
            video.pause();
          }
        });
      }, { threshold: 0.3 })
    : null;

  const configurePressEmail = (email) => {
    const normalizedEmail = typeof email === "string" ? email.trim() : "";
    if (!normalizedEmail) return;

    document.querySelectorAll("[data-press-email-link]").forEach((link) => {
      link.href = `mailto:${normalizedEmail}`;
      link.hidden = false;
    });
    document.querySelectorAll("[data-press-email-text]").forEach((element) => {
      element.textContent = normalizedEmail;
    });
    document.querySelectorAll("[data-press-email-pending]").forEach((element) => {
      element.hidden = true;
    });
  };

  const configureHeadshot = async (headshot = {}) => {
    if (!(await resourceExists(headshot.src))) return;

    const figure = document.querySelector("[data-developer-headshot]");
    const image = document.querySelector("[data-developer-headshot-image]");
    const placeholder = document.querySelector("[data-developer-headshot-placeholder]");
    const download = document.querySelector("[data-developer-headshot-download]");
    if (!figure || !image) return;

    image.src = headshot.src;
    image.alt = headshot.alt || "Portrait of Garrett Mickelsen";
    figure.hidden = false;
    if (placeholder) placeholder.hidden = true;

    const downloadPath = (await resourceExists(headshot.download)) ? headshot.download : headshot.src;
    if (download) {
      download.href = downloadPath;
      download.hidden = false;
    }
  };

  const configureMasterAssets = async (config) => {
    const assetDefinitions = [
      {
        path: config.TRANSPARENT_LOGO?.png,
        selector: "[data-transparent-logo-png]",
        label: "Download Transparent Logo",
        resolution: config.TRANSPARENT_LOGO?.resolution
      },
      {
        path: config.TRANSPARENT_LOGO?.svg,
        selector: "[data-transparent-logo-svg]",
        label: "Download Transparent Logo (SVG)",
        resolution: ""
      },
      {
        path: config.KEY_ART_MASTER?.src,
        selector: "[data-key-art-master]",
        label: "Download Key Art",
        resolution: config.KEY_ART_MASTER?.resolution
      }
    ];

    let keyArtMasterAvailable = false;
    for (const asset of assetDefinitions) {
      if (!(await resourceExists(asset.path))) continue;
      const link = document.querySelector(asset.selector);
      if (!link) continue;

      link.href = asset.path;
      link.textContent = asset.resolution ? `${asset.label} (${asset.resolution})` : asset.label;
      link.hidden = false;
      if (asset.selector === "[data-key-art-master]") keyArtMasterAvailable = true;
    }

    if (keyArtMasterAvailable) {
      const pending = document.querySelector("[data-master-assets-pending]");
      if (pending) pending.hidden = true;
    }
  };

  const addCaptureDownload = (container, path, label) => {
    if (!container || !path) return;
    const link = document.createElement("a");
    link.href = path;
    link.download = "";
    link.textContent = label;
    container.append(link);
  };

  const configureCaptures = async (captures = {}) => {
    const grid = document.querySelector("[data-captures-grid]");
    const emptyMessage = document.querySelector("[data-captures-empty]");
    let visibleCaptures = 0;

    for (const card of document.querySelectorAll("[data-capture-id]")) {
      const capture = captures[card.dataset.captureId] || {};
      const entries = await Promise.all(
        ["preview", "gif", "webm", "mp4", "still"].map(async (key) => [key, capture[key], await resourceExists(capture[key])])
      );
      const available = Object.fromEntries(entries.filter(([, , exists]) => exists).map(([key, path]) => [key, path]));
      if (Object.keys(available).length === 0) continue;

      const previewPath = available.preview || available.still || available.webm || available.mp4;
      const preview = card.querySelector(".capture-preview");
      const image = card.querySelector("[data-capture-image]");
      const video = card.querySelector("[data-capture-video]");
      const downloads = card.querySelector("[data-capture-downloads]");
      const isImage = /\.(?:gif|png|jpe?g|webp|avif)(?:\?.*)?$/i.test(previewPath || "");

      if (preview && previewPath) preview.hidden = false;
      if (isImage && image) {
        image.src = previewPath;
        image.hidden = false;
      } else if (video) {
        if (available.still) video.poster = available.still;
        video.autoplay = false;
        video.muted = true;
        video.loop = true;
        const videoPaths = [available.webm, available.mp4, available.preview].filter(Boolean);
        for (const path of [...new Set(videoPaths)]) {
          if (/\.(?:webm|mp4)(?:\?.*)?$/i.test(path)) {
            const source = document.createElement("source");
            source.src = path;
            source.type = path.toLowerCase().includes(".webm") ? "video/webm" : "video/mp4";
            video.append(source);
          }
        }
        if (video.querySelector("source")) {
          video.hidden = false;
          video.load();
          if (playbackObserver) playbackObserver.observe(video);
        }
      }

      const addedDownloads = new Set();
      const addUniqueDownload = (path, label) => {
        if (!path || addedDownloads.has(path)) return;
        addCaptureDownload(downloads, path, label);
        addedDownloads.add(path);
      };
      addUniqueDownload(available.gif, "Download GIF");
      addUniqueDownload(available.webm, "Download WebM");
      addUniqueDownload(available.mp4, "Download MP4");
      if (available.preview && ![available.gif, available.webm, available.mp4].includes(available.preview)) {
        addUniqueDownload(available.preview, "Download preview");
      }
      addUniqueDownload(available.still, "Download still");

      card.hidden = false;
      visibleCaptures += 1;
    }

    if (visibleCaptures > 0 && grid) {
      grid.hidden = false;
      if (emptyMessage) emptyMessage.hidden = true;
    }
  };

  const loadPressKitConfig = async () => {
    try {
      const response = await fetch("press-kit-config.json", { cache: "no-store" });
      if (!response.ok) return;
      const config = await response.json();

      configurePressEmail(config.PRESS_EMAIL);
      await Promise.all([
        configureHeadshot(config.DEVELOPER_HEADSHOT),
        configureMasterAssets(config),
        configureCaptures(config.GAMEPLAY_CAPTURES)
      ]);
    } catch {
      // The public fallbacks remain usable if the optional configuration cannot load.
    }
  };

  loadPressKitConfig();
})();
