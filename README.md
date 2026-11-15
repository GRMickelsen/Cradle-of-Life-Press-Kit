# The Cradle of Life Press Kit

This repository contains the official static press-kit website for **The Cradle of Life**, a dark-fantasy tactical RPG developed by Garrett Mickelsen and published by Milo's Games.

The site is plain HTML, CSS, and JavaScript. It has no build step, backend, database, CMS, or third-party runtime dependency.

## Preview locally

The simplest option is to open `index.html` in a browser.

For a more reliable local preview, open PowerShell in this folder and run:

```powershell
python -m http.server 8765
```

Then visit `http://127.0.0.1:8765/` on the same computer. This local address will not work from a phone or another device. Stop the server with `Ctrl+C`.

## Main files

- `index.html` contains all visible press-kit content and metadata.
- `css/style.css` contains the full visual design and responsive rules.
- `js/main.js` controls the scroll-led opening, mobile navigation, copy buttons, gallery expansion, and screenshot viewer.
- `press-kit-config.json` controls the public email and optional media that should appear only after approved files exist.
- `assets/` contains web-facing artwork, the red transparent logo, screenshots, pantheon portraits, gameplay captures, and the official trailer.
- `output/pdf/` contains localized one-page press fact sheets.
- `downloads/The_Cradle_of_Life_Press_Kit.zip` is the public downloadable archive.
- `tools/build-press-kit.ps1` rebuilds the downloadable archive from current site assets.
- `assets/SOURCES.md` records where each selected asset came from.

## Update screenshots

1. Put the new full-resolution JPG or PNG in `assets/screenshots/`.
2. Open `index.html` and find the `gallery-grid` section.
3. Update the image path, download path, caption, width, height, and alt text.
4. Keep screenshots truthful to currently playable or publicly announced content.
5. Run the archive rebuild script described below.

The gallery shows six featured screenshots first and reveals the full set through the **View all 12 screenshots** button. It loads images lazily after the first screenshot. Full-resolution images are used for both viewing and individual downloads.

## Update the opening sequence

The four opening chapters are in `index.html` under `first-impression`. The first chapter places the supplied metallic logo over the logo-free 3840 × 1240 library artwork. The remaining chapters use the tactical-combat capture, Shimmer-combat capture, and the Gods and Cradle artwork. The layout and mobile framing are in the final sections of `css/style.css`; chapter switching is handled in `js/main.js`.

Keep the opening to a small number of short, specific ideas. If a video path changes, update both its `<source>` and poster image in `index.html`.

## Update game descriptions

Open `index.html` and search for:

- `One-sentence description`
- `Short description`
- `Long description`

Update the word-count labels when the copy changes. Keep claims aligned with the current Steam page and current demo.

## Press email

The dedicated public press address is configured in `press-kit-config.json`:

```json
"PRESS_EMAIL": "press.cradleoflife@outlook.com"
```

Update this value if the public press address changes, then rebuild the ZIP so its Contact file matches.

## Optional assets

Optional files are controlled through `press-kit-config.json`. A section or download stays hidden unless its configured file exists. The current developer headshot, gameplay captures, transparent logo, and 3840 × 1240 library hero are all configured.

## Replace the developer headshot

1. Add the approved image as `assets/developer/Developer_GarrettMickelsen.jpg`.
2. Set `DEVELOPER_HEADSHOT.src` and `DEVELOPER_HEADSHOT.download` in `press-kit-config.json` to that path.
3. Set a concise `alt` value if the default needs changing.
4. Rebuild the downloadable ZIP.

If the file is missing or the configuration value is empty, the site uses a clean monogram placeholder and does not request a broken image.

## Gameplay capture files

The website no longer has a separate gameplay-captures section. Approved capture files remain available in the downloadable press-kit ZIP. Put replacements in `assets/gameplay/` using the same descriptive naming pattern.

- `CradleOfLife_Gameplay_TacticalCombat.gif`
- `CradleOfLife_Gameplay_TacticalCombat.webm`
- `CradleOfLife_Gameplay_Shimmer.gif`
- `CradleOfLife_Gameplay_Shimmer.webm`
- `CradleOfLife_Gameplay_Customization.gif`
- `CradleOfLife_Gameplay_Customization.webm`
- `CradleOfLife_Gameplay_Exploration.gif`
- `CradleOfLife_Gameplay_Exploration.webm`

Each capture supports `preview`, `gif`, `webm`, `mp4`, and `still` paths in `press-kit-config.json`. The build script uses these paths when assembling the ZIP.

## Add the transparent logo

The approved red logo is stored at `assets/logo/CradleOfLife_Logo_Transparent.png` and configured in `press-kit-config.json`. An optional matching red SVG can be added later.

The compact metallic header logo is stored separately at `assets/logo/CradleOfLife_ShortcutLogo_512x512.png`.

Do not upscale the existing Steam header or capsule.

## Replace the key-art master

The current downloadable master is `assets/key-art/CradleOfLife_LibraryHero_3840x1240.png`. To replace it, update `KEY_ART_MASTER.src` and `KEY_ART_MASTER.resolution` in `press-kit-config.json`.

Do not enlarge the current web art to create this file.

## Rebuild the downloadable ZIP

From PowerShell in the project folder, run:

```powershell
powershell -ExecutionPolicy Bypass -File tools/build-press-kit.ps1
```

The script creates `downloads/The_Cradle_of_Life_Press_Kit.zip` from the current assets. It replaces only that ZIP file.

## Deploy with GitHub Pages

1. Create a GitHub repository named `Cradle-of-Life-Press-Kit`.
2. Push this project to the repository's `main` branch.
3. On GitHub, open **Settings**, then **Pages**.
4. Under **Build and deployment**, choose **Deploy from a branch**.
5. Select the `main` branch and `/ (root)`, then save.
6. GitHub will display the public URL after deployment finishes.

No GitHub Actions workflow is required. The included `.nojekyll` file keeps GitHub Pages from applying Jekyll processing.

The canonical, Open Graph, and Twitter metadata use the public GitHub Pages URL. Re-test link previews after changing the domain or social image.

## Source authority

The current press materials were reviewed on November 6, 2026 against:

- Live Steam app `4580240`
- Steam demo app `4655560`
- Repository `main` commit `549b2daad3703abfbc0dfe933ed613b2c9b0170c`

Re-check public facts and screenshots before major announcements or release changes.
