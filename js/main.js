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
  let activeGalleryIndex = 0;

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
  };

  galleryButtons.forEach((button, index) => {
    button.addEventListener("click", () => {
      if (!lightbox || typeof lightbox.showModal !== "function") {
        window.open(button.dataset.full, "_blank", "noopener");
        return;
      }

      showGalleryImage(index);
      lightbox.showModal();
    });
  });

  lightbox?.querySelector("[data-lightbox-close]")?.addEventListener("click", () => lightbox.close());
  lightbox?.querySelector("[data-lightbox-prev]")?.addEventListener("click", () => showGalleryImage(activeGalleryIndex - 1));
  lightbox?.querySelector("[data-lightbox-next]")?.addEventListener("click", () => showGalleryImage(activeGalleryIndex + 1));

  lightbox?.addEventListener("click", (event) => {
    if (event.target === lightbox) lightbox.close();
  });

  lightbox?.addEventListener("keydown", (event) => {
    if (event.key === "ArrowLeft") showGalleryImage(activeGalleryIndex - 1);
    if (event.key === "ArrowRight") showGalleryImage(activeGalleryIndex + 1);
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

    let visibleAssets = 0;
    for (const asset of assetDefinitions) {
      if (!(await resourceExists(asset.path))) continue;
      const link = document.querySelector(asset.selector);
      if (!link) continue;

      link.href = asset.path;
      link.textContent = asset.resolution ? `${asset.label} (${asset.resolution})` : asset.label;
      link.hidden = false;
      visibleAssets += 1;
    }

    if (visibleAssets > 0) {
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
        ["preview", "webm", "mp4", "still"].map(async (key) => [key, capture[key], await resourceExists(capture[key])])
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
        const videoPaths = [available.webm, available.mp4, available.preview].filter(Boolean);
        for (const path of [...new Set(videoPaths)]) {
          if (/\.(?:webm|mp4)(?:\?.*)?$/i.test(path)) {
            const source = document.createElement("source");
            source.src = path;
            source.type = path.toLowerCase().includes(".webm") ? "video/webm" : "video/mp4";
            video.append(source);
          }
        }
        if (video.querySelector("source")) video.hidden = false;
      }

      const addedDownloads = new Set();
      const addUniqueDownload = (path, label) => {
        if (!path || addedDownloads.has(path)) return;
        addCaptureDownload(downloads, path, label);
        addedDownloads.add(path);
      };
      addUniqueDownload(available.preview, /\.gif(?:\?.*)?$/i.test(available.preview || "") ? "Download GIF" : "Download preview");
      addUniqueDownload(available.webm, "Download WebM");
      addUniqueDownload(available.mp4, "Download MP4");
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
