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
- `js/main.js` controls mobile navigation, copy buttons, and the screenshot viewer.
- `press-kit-config.json` controls the public email and optional media that should appear only after approved files exist.
- `assets/` contains the web-facing artwork, screenshots, pantheon portraits, font, and trailer poster.
- `downloads/The_Cradle_of_Life_Press_Kit.zip` is the public downloadable archive.
- `tools/build-press-kit.ps1` rebuilds the downloadable archive from current site assets.
- `assets/SOURCES.md` records where each selected asset came from.

## Update screenshots

1. Put the new full-resolution JPG or PNG in `assets/screenshots/`.
2. Open `index.html` and find the `gallery-grid` section.
3. Update the image path, download path, caption, width, height, and alt text.
4. Keep screenshots truthful to currently playable or publicly announced content.
5. Run the archive rebuild script described below.

The gallery loads images lazily after the first screenshot. Full-resolution images are used for both viewing and individual downloads.

## Update game descriptions

Open `index.html` and search for:

- `One-sentence description`
- `Short description`
- `Long description`

Update the word-count labels when the copy changes. Keep claims aligned with the current Steam page and current demo.

## Configure the press email

Open `press-kit-config.json` and set `PRESS_EMAIL` after the dedicated public address is active:

```json
"PRESS_EMAIL": ""
```

Leave the value empty until the approved address is live, then place that address between the quotation marks. The website will display `Public press email pending` and will not create a mail link while the value is empty. Rebuild the ZIP after changing the value so its Contact file matches.

## Pending optional assets

Optional files are controlled through `press-kit-config.json`. A section or download stays hidden unless its configured file exists.

- Developer headshot
- Four gameplay captures
- High-resolution transparent logo
- Print-quality key-art master
- Final public press email

## Replace the developer headshot

1. Add the approved image as `assets/developer/Developer_GarrettMickelsen.jpg`.
2. Set `DEVELOPER_HEADSHOT.src` and `DEVELOPER_HEADSHOT.download` in `press-kit-config.json` to that path.
3. Set a concise `alt` value if the default needs changing.
4. Rebuild the downloadable ZIP.

If the file is missing or the configuration value is empty, the site uses a clean monogram placeholder and does not request a broken image.

## Add gameplay captures

Put approved files in `assets/gameplay/` using these recommended names:

- `CradleOfLife_Gameplay_TacticalCombat.gif`
- `CradleOfLife_Gameplay_TacticalCombat.webm`
- `CradleOfLife_Gameplay_Shimmer.gif`
- `CradleOfLife_Gameplay_Shimmer.webm`
- `CradleOfLife_Gameplay_Customization.gif`
- `CradleOfLife_Gameplay_Customization.webm`
- `CradleOfLife_Gameplay_Exploration.gif`
- `CradleOfLife_Gameplay_Exploration.webm`

Each capture supports `preview`, `webm`, `mp4`, and `still` paths in `press-kit-config.json`. Cards remain hidden until at least one configured file exists. Prefer a lightweight still or optimized GIF for `preview`; full WebM and MP4 files can remain direct downloads.

## Add the transparent logo

Place the approved file at `assets/logo/CradleOfLife_Logo_Transparent.png`. An optional SVG can be added beside it. Configure `TRANSPARENT_LOGO.png`, `TRANSPARENT_LOGO.svg`, and the source `resolution` in `press-kit-config.json`.

Do not upscale the existing Steam header or capsule.

## Add the key-art master

Place the approved original at `assets/key-art/CradleOfLife_KeyArt_Master.png`. Configure `KEY_ART_MASTER.src` and `KEY_ART_MASTER.resolution` in `press-kit-config.json`.

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

After a final public URL exists, test the link preview on the intended social platforms. The Open Graph and Twitter image paths currently use a repository-relative path because no production domain has been assigned.

## Source authority

The first pass was verified on September 9, 2026 against:

- Live Steam app `4580240`
- Steam demo app `4655560`
- Repository `main` commit `549b2daad3703abfbc0dfe933ed613b2c9b0170c`

Re-check public facts and screenshots before major announcements or release changes.
