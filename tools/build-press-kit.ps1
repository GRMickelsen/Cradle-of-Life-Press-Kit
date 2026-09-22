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

Release status: Coming soon
Platforms: Windows and macOS
Press contact: $pressEmail

This archive was assembled from current public Steam materials and repository main on September 9, 2026.
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

The Cradle of Life is a dark-fantasy tactical RPG where grid combat, hunger, psychological pressure, reality-tearing Shimmers, and the attention of six divided gods shape Caelis's search for the Needle.

SHORT DESCRIPTION

The Cradle of Life is a dark-fantasy tactical RPG built around deliberate grid combat and unguided exploration. As Caelis, a weathered warrior searching for the forgotten Needle, players manage Action Points, terrain, weapon reach, Poise, wounds, Hunger, and Psych while investigating a world being torn apart by Shimmers. People and records may contradict each other, and six gods with incompatible visions are paying attention. The currently available Steam demo introduces the journey through Thornvale, its surrounding wilderness, and the first signs of a much larger crisis.

LONG DESCRIPTION

Across the land, reality-tearing phenomena called Shimmers appear without warning. Villages vanish, ancient things stir beneath the earth, and six gods who have remained silent for centuries begin to speak. The Cradle of Life follows Caelis, a weathered warrior sent to recover a forgotten relic called the Needle, into a conflict where every witness carries a different version of the truth.

Exploration is built around observation rather than a trail of objective markers. Players talk to people, read what was left behind, and search houses, caves, ruins, and roads for discoveries that may complicate the question they were trying to answer. Hunger and Psych persist outside battle, turning time and unstable places into pressures of their own.

Combat takes place on a tactical grid. Movement costs Action Points; height, reach, armor, weapon choice, wounds, Poise, and fear alter the shape of each encounter. Caelis's appearance changes in both his world sprite and portrait, while weapon familiarity, Resolve, and decisions shape the survivor he becomes. The Steam demo presents the opening journey through Thornvale and the first encounter with the wider mystery.

CONTENT WARNINGS

Dark-fantasy violence, psychological horror themes, disturbing imagery, references to abuse and implied sexual violence, and mature story content. No explicit nudity or explicit sexual content.
"@

$captureReadme = @"
GAMEPLAY CAPTURES

Approved captures will use this folder when supplied:

Tactical Combat
Grid-based tactical combat featuring positioning, Action Points, terrain, height, status effects, and enemy behavior.

Shimmer Distortion
A glimpse of the Shimmer and its visual distortion effects.

Character Customization
The character creation system used to shape the player's version of Caelis.

Exploration
Exploration through the hand-built world of The Cradle of Life.

GIF previews and WebM, MP4, or still-image downloads may be included. No temporary footage has been manufactured.
"@

$developerBiography = @"
GARRETT MICKELSEN - APPROVED BIOGRAPHY

Garrett Mickelsen is the solo developer behind The Cradle of Life, an independent tactical role-playing game built in RPG Maker MZ. An active-duty U.S. Marine officer and military historian, Mickelsen began developing the game as a personal creative project, drawing on a lifelong interest in history, mythology, and storytelling. Much of the world's earliest lore grew from stories told by his father around campfires when he was young.

Developed largely in his spare time while balancing military service and family life, The Cradle of Life combines exploration, choice-driven storytelling, character customization, and grid-based tactical combat in a dark fantasy world shaped by gods, forgotten places, and the consequences of the player's decisions.

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

Set-Content -LiteralPath (Join-Path $kitRoot "README.txt") -Value $readme -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Fact_Sheet\Fact_Sheet.txt") -Value $factSheet -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Gameplay_Captures\README.txt") -Value $captureReadme -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Developer\Garrett_Mickelsen_Biography.txt") -Value $developerBiography -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Creator_Guidelines\Creator_and_Press_Guidelines.txt") -Value $creatorGuidelines -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Fact_Sheet\Pronunciation_Guide.txt") -Value $pronunciationGuide -Encoding utf8
Set-Content -LiteralPath (Join-Path $kitRoot "Contact\Press_Contact.txt") -Value $contactReadme -Encoding utf8

Copy-Item -LiteralPath (Join-Path $projectRoot "assets\logo\steam-header.jpg") -Destination (Join-Path $kitRoot "Logos\The_Cradle_of_Life_Steam_Header.jpg")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\key-art\cradle-key-art.png") -Destination (Join-Path $kitRoot "Key_Art\The_Cradle_of_Life_Key_Art.png")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\key-art\steam-capsule.jpg") -Destination (Join-Path $kitRoot "Key_Art\The_Cradle_of_Life_Steam_Capsule.jpg")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\key-art\steam-page-background.jpg") -Destination (Join-Path $kitRoot "Key_Art\The_Cradle_of_Life_Steam_Background.jpg")
Copy-Item -LiteralPath (Join-Path $projectRoot "assets\trailer\teaser-trailer-poster.jpg") -Destination (Join-Path $kitRoot "Key_Art\The_Cradle_of_Life_Teaser_Poster.jpg")
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
  $candidate = Join-Path $projectRoot $RelativePath
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

Copy-ConfiguredAsset -RelativePath $config.TRANSPARENT_LOGO.png -DestinationDirectory (Join-Path $kitRoot "Logos")
Copy-ConfiguredAsset -RelativePath $config.TRANSPARENT_LOGO.svg -DestinationDirectory (Join-Path $kitRoot "Logos")
Copy-ConfiguredAsset -RelativePath $config.KEY_ART_MASTER.src -DestinationDirectory (Join-Path $kitRoot "Key_Art")

foreach ($captureProperty in $config.GAMEPLAY_CAPTURES.PSObject.Properties) {
  $capture = $captureProperty.Value
  foreach ($assetProperty in @("preview", "webm", "mp4", "still")) {
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
