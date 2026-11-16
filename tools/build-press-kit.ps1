$ErrorActionPreference = "Stop"

$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$configPath = Join-Path $projectRoot "press-kit-config.json"
$config = Get-Content -Raw -LiteralPath $configPath | ConvertFrom-Json
$pressEmail = if ([string]::IsNullOrWhiteSpace($config.PRESS_EMAIL)) { "PUBLIC PRESS EMAIL PENDING" } else { $config.PRESS_EMAIL.Trim() }
$archivePath = Join-Path $projectRoot "downloads\The_Cradle_of_Life_Press_Kit.zip"
$tempBase = [System.IO.Path]::GetTempPath()
$stageParent = Join-Path $tempBase ("CradlePressKit-" + [guid]::NewGuid().ToString("N"))
$kitRoot = Join-Path $stageParent "The_Cradle_of_Life_Press_Kit"

$folders = @(
  $kitRoot,
  (Join-Path $kitRoot "Fact_Sheet"),
  (Join-Path $kitRoot "Logos"),
  (Join-Path $kitRoot "Key_Art"),
  (Join-Path $kitRoot "Key_Art\Pantheon"),
  (Join-Path $kitRoot "Screenshots"),
  (Join-Path $kitRoot "Gameplay_Captures"),
  (Join-Path $kitRoot "Trailer"),
  (Join-Path $kitRoot "Creator_Guidelines"),
  (Join-Path $kitRoot "Developer"),
  (Join-Path $kitRoot "Contact")
)

New-Item -ItemType Directory -Force -Path $folders | Out-Null

$readme = @"
THE CRADLE OF LIFE - PRESS KIT

The Cradle of Life is a dark-fantasy tactical RPG developed by Garrett Mickelsen and published by Milo's Games.

Steam and demo:
https://store.steampowered.com/app/4580240/The_Cradle_of_Life/

Official demo trailer:
https://youtu.be/dXcrJQChVNU

Release status: Coming soon
Platforms: Windows and macOS
Press contact: $pressEmail

This archive was assembled from current public Steam materials and repository main on November 15, 2026.
Please preserve screenshot aspect ratios and do not imply that unannounced content is included in the current demo.
"@

$factSheet = @"
THE CRADLE OF LIFE - FACT SHEET

Title: The Cradle of Life
Genre: Dark Fantasy RPG / Tactical RPG / Turn-Based Tactics
Developer: Garrett Mickelsen
Publisher: Milo's Games
Players: Single-player
Platforms: Windows and macOS
Release: Coming soon
Demo: Available now on Steam
Typical demo playtime: Approximately 1 hour. Players who explore optional quests, dialogue, and lore may take longer.
Languages: English, Japanese, Korean, Simplified Chinese, Traditional Chinese
Engine: RPG Maker MZ - heavily customized
Steam: https://store.steampowered.com/app/4580240/The_Cradle_of_Life/
Press contact: $pressEmail

ONE-SENTENCE DESCRIPTION

The Cradle of Life is a dark-fantasy tactical RPG combining deliberate grid combat, unguided exploration, survival pressure, and consequential choices in a world being torn apart by Shimmers and six divided gods.

SHORT DESCRIPTION

The Cradle of Life is a dark-fantasy tactical RPG built around deliberate grid combat, unguided exploration, and difficult choices in a world growing less stable by the day. As Caelis, players investigate Shimmers that distort places, memory, and human lives while managing Action Points, terrain, weapon reach, Poise, wounds, Hunger, and Psych. People and records often disagree, and six gods with incompatible visions respond to what Caelis does. The Steam demo introduces Thornvale, its surrounding wilderness, and the first signs of a larger crisis.

LONG DESCRIPTION

Across the land, Shimmers appear without warning. They alter places, bodies, memory, and distance. Villages disappear, old dangers return, and six gods who have been silent for centuries begin speaking again. Caelis survives the destruction of Craighollow and reaches Thornvale, where a local crisis draws him into questions no witness, record, or god can answer completely.

Exploration is built around observation rather than a trail of objective markers. Players question people, read what was left behind, and search roads, homes, caves, ruins, and forests for discoveries that may complicate the problem they were trying to solve. Hunger and Psych persist outside battle, turning time and unstable places into pressures of their own.

Combat takes place on a tactical grid. Movement and attacks draw from the same Action Point pool. Height, weapon reach, armor, wounds, Poise, fear, and terrain affect each turn. Caelis's appearance changes in both his world sprite and portrait, while weapon familiarity, Resolve, and decisions shape the survivor he becomes.

Caelis's road eventually leads toward the Needle, a forgotten relic tied to the world's history, and the Cradle beyond the Great Ocean. Neither offers a simple answer. The Steam demo covers the opening in Thornvale and introduces the Shimmers, the gods, and the human consequences of a world becoming less stable.

CONTENT WARNINGS

Dark-fantasy violence, psychological horror themes, disturbing imagery, references to abuse and implied sexual violence, and mature story content. No explicit nudity or explicit sexual content.
"@

$captureReadme = @"
GAMEPLAY CAPTURES

Approved captures will use this folder when supplied:

Tactical Combat
A tactical encounter showing movement, Action Points, terrain, height, status effects, and enemy behavior.

Exploration
Exploring the roads, ruins, and wilderness around Thornvale.

Character Creation
Customize Caelis with a world sprite and portrait that reflect the same appearance choices.

Shimmer Combat
A hostile Shimmer encounter where positioning and enemy pressure can quickly narrow the safe choices.

Optimized GIF previews where available, MP4 files, and still-image downloads are included. The captures originate from approved game and Steam media.
"@

$developerBiography = @"
GARRETT MICKELSEN - APPROVED BIOGRAPHY

Garrett Mickelsen is the solo developer of The Cradle of Life, an independent tactical RPG made in RPG Maker MZ. He is also an active-duty U.S. Marine officer and military historian. The game began as a personal project built around his interests in history, mythology, and storytelling. Some of its oldest lore came from stories his father told around campfires when he was young.

Most of the work is done in his spare time around military service and family life. The game combines exploration, player choice, character customization, and grid-based combat in a dark fantasy setting of gods and forgotten places.

DISCLAIMER

The Cradle of Life is an independent project and is not affiliated with or endorsed by the U.S. Marine Corps or Department of Defense.
"@

$creatorGuidelines = @"
THE CRADLE OF LIFE - CREATOR AND PRESS GUIDELINES

CREATOR MONETIZATION POLICY

Yes. Content creators are welcome to monetize videos, livestreams, reviews, previews, guides, and other original content featuring The Cradle of Life through advertising, subscriptions, donations, sponsorships, or similar platform-supported monetization. No separate permission is required.

STREAMING AND VIDEO POLICY

You are welcome to stream, record, review, discuss, and create videos featuring The Cradle of Life, including the public demo. Gameplay footage, screenshots, trailers, and materials supplied through this press kit may be used for editorial and creator coverage of the game. No prior approval is required, and criticism—positive or negative—is welcome.

SPOILER GUIDANCE

Creators and press may show and discuss anything contained in the publicly available demo. We ask that major late-demo story revelations, god-related choices, and the final sequence not be used prominently in thumbnails, titles, or social-media previews without a spoiler warning. Full playthroughs and spoiler discussions are completely welcome when appropriately labeled.

DEMO PLAYTIME

Typical demo playtime is approximately 1 hour. Players who explore optional quests, dialogue, and lore may take longer.

MUSIC AND FOOTAGE USAGE

Official screenshots, trailers, GIFs, and gameplay footage provided in this press kit may be used for editorial, review, preview, and creator coverage of The Cradle of Life. In-game music and audio may be included as part of captured gameplay or official footage. Please do not extract, redistribute, or upload individual music tracks or game assets as standalone content.
"@

$pronunciationGuide = @"
THE CRADLE OF LIFE - PRONUNCIATION GUIDE

Caelis: KAY-liss
Airealen: AIR-real-en
Yrris: EYE-riss
Thozur: THOH-zur
Valen: VAY-len
Naerun: NAY-run
Zhal: ZALL
"@

$contactReadme = @"
PRESS / CREATOR CONTACT

$pressEmail

Steam and demo:
https://store.steampowered.com/app/4580240/The_Cradle_of_Life/
"@

$socialLinks = @"
THE CRADLE OF LIFE - OFFICIAL LINKS

Steam: https://store.steampowered.com/app/4580240/The_Cradle_of_Life/
YouTube: https://www.youtube.com/@cradleoflife_dev
Official demo trailer: https://youtu.be/dXcrJQChVNU
X / Global: https://x.com/grmmilo
X / Japanese: https://x.com/cradleoflife_jp
Instagram: https://www.instagram.com/cradleoflife_dev/
TikTok: https://www.tiktok.com/@cradleoflife_dev
Facebook: https://www.facebook.com/1318164371390816
Bluesky: https://bsky.app/profile/cradleoflifedev.bsky.social
Threads: https://www.threads.com/@mickelsengarrett
Reddit: https://www.reddit.com/user/Strong-Detail-2631/
Bilibili: https://space.bilibili.com/en/3747575731587915
Steam Community: https://steamcommunity.com/app/4580240
"@

Set-Content -LiteralPath (Join-Path $kitRoot "README.txt") -Value $readme -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Fact_Sheet\Fact_Sheet.txt") -Value $factSheet -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Gameplay_Captures\README.txt") -Value $captureReadme -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Developer\Garrett_Mickelsen_Biography.txt") -Value $developerBiography -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Creator_Guidelines\Creator_and_Press_Guidelines.txt") -Value $creatorGuidelines -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Fact_Sheet\Pronunciation_Guide.txt") -Value $pronunciationGuide -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Contact\Press_Contact.txt") -Value $contactReadme -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Contact\Official_Links.txt") -Value $socialLinks -Encoding utf8

Copy-Item -LiteralPath (Join-Path $projectRoot "assets\logo\steam-header.jpg") -Destination (Join-Path $kitRoot "Logos\The_Cradle_of_Life_Steam_Header.jpg")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\logo\CradleOfLife_ShortcutLogo_512x512.png") -Destination (Join-Path $kitRoot "Logos\CradleOfLife_ShortcutLogo_512x512.png")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\logo\CradleOfLife_MainLogo_1232x706.png") -Destination (Join-Path $kitRoot "Logos\CradleOfLife_MainLogo_1232x706.png")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\key-art\cradle-key-art.png") -Destination (Join-Path $kitRoot "Key_Art\The_Cradle_of_Life_Key_Art.png")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\key-art\CradleOfLife_MainCapsule_1232x706.png") -Destination (Join-Path $kitRoot "Key_Art\CradleOfLife_MainCapsule_1232x706.png")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\key-art\CradleOfLife_VerticalCapsule_748x896.png") -Destination (Join-Path $kitRoot "Key_Art\CradleOfLife_VerticalCapsule_748x896.png")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\key-art\CradleOfLife_ShortcutCapsule_512x512.png") -Destination (Join-Path $kitRoot "Key_Art\CradleOfLife_ShortcutCapsule_512x512.png")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\key-art\steam-capsule.jpg") -Destination (Join-Path $kitRoot "Key_Art\The_Cradle_of_Life_Steam_Capsule.jpg")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\key-art\steam-page-background.jpg") -Destination (Join-Path $kitRoot "Key_Art\The_Cradle_of_Life_Steam_Background.jpg")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\trailer\official-trailer-poster.png") -Destination (Join-Path $kitRoot "Trailer\The_Cradle_of_Life_Official_Trailer_Poster.png")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\trailer\CradleOfLife_Official_Demo_Trailer_1080p.mp4") -Destination (Join-Path $kitRoot "Trailer\The_Cradle_of_Life_Official_Demo_Trailer_1080p.mp4")
Get-ChildItem -LiteralPath (Join-Path $projectRoot "output\pdf") -Filter "*.pdf" -File | Copy-Item -Destination (Join-Path $kitRoot "Fact_Sheet")
$pantheonFiles = Get-ChildItem -LiteralPath (Join-Path $projectRoot "assets\pantheon") -File
Copy-Item -LiteralPath $pantheonFiles.FullName -Destination (Join-Path $kitRoot "Key_Art\Pantheon")
$screenshotFiles = Get-ChildItem -LiteralPath (Join-Path $projectRoot "assets\screenshots") -File
Copy-Item -LiteralPath $screenshotFiles.FullName -Destination (Join-Path $kitRoot "Screenshots")

function Copy-ConfiguredAsset {
  param(
    [string]$RelativePath,
    [string]$DestinationDirectory
  )

  if ([string]::IsNullOrWhiteSpace($RelativePath)) { return }
  $fileRelativePath = ($RelativePath -split '[?#]', 2)[0]
  $candidate = Join-Path $projectRoot $fileRelativePath
  if (-not (Test-Path -LiteralPath $candidate -PathType Leaf)) { return }

  $resolvedCandidate = (Resolve-Path -LiteralPath $candidate).Path
  if (-not $resolvedCandidate.StartsWith($projectRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Configured asset is outside the press-kit project: $RelativePath"
  }

  Copy-Item -LiteralPath $resolvedCandidate -Destination $DestinationDirectory -Force
}

Copy-ConfiguredAsset -RelativePath $config.DEVELOPER_HEADSHOT.download -DestinationDirectory (Join-Path $kitRoot "Developer")
if ([string]::IsNullOrWhiteSpace($config.DEVELOPER_HEADSHOT.download)) {
  Copy-ConfiguredAsset -RelativePath $config.DEVELOPER_HEADSHOT.src -DestinationDirectory (Join-Path $kitRoot "Developer")
}
Copy-ConfiguredAsset -RelativePath "assets/developer/garrett-mickelsen-service-and-family.jpg" -DestinationDirectory (Join-Path $kitRoot "Developer")

Copy-ConfiguredAsset -RelativePath $config.TRANSPARENT_LOGO.png -DestinationDirectory (Join-Path $kitRoot "Logos")
Copy-ConfiguredAsset -RelativePath $config.TRANSPARENT_LOGO.svg -DestinationDirectory (Join-Path $kitRoot "Logos")
Copy-ConfiguredAsset -RelativePath $config.KEY_ART_MASTER.src -DestinationDirectory (Join-Path $kitRoot "Key_Art")

foreach ($captureProperty in $config.GAMEPLAY_CAPTURES.PSObject.Properties) {
  $capture = $captureProperty.Value
  foreach ($assetProperty in @("preview", "gif", "webm", "mp4", "still")) {
    Copy-ConfiguredAsset -RelativePath $capture.$assetProperty -DestinationDirectory (Join-Path $kitRoot "Gameplay_Captures")
  }
}

if (Test-Path -LiteralPath $archivePath) {
  Remove-Item -LiteralPath $archivePath -Force
}

Compress-Archive -LiteralPath $kitRoot -DestinationPath $archivePath -CompressionLevel Optimal

$resolvedStage = (Resolve-Path -LiteralPath $stageParent).Path
$resolvedTemp = (Resolve-Path -LiteralPath $tempBase).Path
if (-not $resolvedStage.StartsWith($resolvedTemp, [System.StringComparison]::OrdinalIgnoreCase)) {
  throw "Refusing to remove a staging directory outside the system temp directory."
}

Remove-Item -LiteralPath $resolvedStage -Recurse -Force
Write-Output "Created $archivePath"
