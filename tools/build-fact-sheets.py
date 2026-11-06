from pathlib import Path

from reportlab.lib.colors import HexColor
from reportlab.lib.pagesizes import A4
from reportlab.lib.utils import ImageReader
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen import canvas
from reportlab.graphics import renderPDF
from reportlab.graphics.barcode.qr import QrCodeWidget
from reportlab.graphics.shapes import Drawing


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "output" / "pdf"
LOGO = ROOT / "assets" / "logo" / "CradleOfLife_Logo_Transparent.png"
STEAM = "https://store.steampowered.com/app/4580240/The_Cradle_of_Life/"
PRESS_EMAIL = "press.cradleoflife@outlook.com"

PAGE_W, PAGE_H = A4
MARGIN = 38
RED = HexColor("#7a211f")
DARK = HexColor("#171213")
INK = HexColor("#282326")
MUTED = HexColor("#655d60")
PAPER = HexColor("#f3efe8")
PANEL = HexColor("#e6ded5")
VIOLET = HexColor("#5b456f")


pdfmetrics.registerFont(TTFont("Cradle-JA", "C:/Windows/Fonts/YuGothR.ttc", subfontIndex=0))
pdfmetrics.registerFont(TTFont("Cradle-KO", "C:/Windows/Fonts/malgun.ttf"))
pdfmetrics.registerFont(TTFont("Cradle-ZH-CN", "C:/Windows/Fonts/msyh.ttc", subfontIndex=0))
pdfmetrics.registerFont(TTFont("Cradle-ZH-TW", "C:/Windows/Fonts/msjh.ttc", subfontIndex=0))


CONTENT = {
    "EN": {
        "font": "Times-Roman",
        "title": "PRESS FACT SHEET",
        "locale": "English",
        "game_title": "The Cradle of Life",
        "pitch": (
            "A dark-fantasy tactical RPG about Caelis, a weathered warrior whose search for answers becomes a hunt for the Needle. "
            "Deliberate grid combat, decisions with visible consequences, and unguided exploration shape the opening journey through Thornvale."
        ),
        "facts_heading": "AT A GLANCE",
        "facts": [
            ("Genre", "Dark Fantasy RPG / Tactical RPG / Turn-Based Tactics"),
            ("Developer", "Garrett Mickelsen"),
            ("Publisher", "Milo's Games"),
            ("Platforms", "Windows and macOS"),
            ("Players", "Single-player"),
            ("Status", "Demo available / Coming soon"),
            ("Demo playtime", "Approximately 1 hour"),
            ("Languages", "English, Japanese, Korean, Simplified Chinese, Traditional Chinese"),
            ("Engine", "RPG Maker MZ - heavily customized"),
        ],
        "difference_heading": "WHAT MAKES IT DIFFERENT",
        "differences": [
            ("Every action has a cost", "Movement and attacks compete for limited Action Points. Height, weapon reach, terrain, wounds, armor, Poise, fear, and positioning reshape every turn."),
            ("Decisions change how the game plays", "Choices affect people, access, later dialogue, and the survivor Caelis becomes. Six divided gods pay attention, but none represents a simple good or evil answer."),
            ("Exploration without a glowing trail", "Players question people, read records, and search roads, homes, caves, ruins, and forests for clues that may complicate the answer they were seeking."),
        ],
        "demo": "FREE DEMO ON STEAM",
        "contact": "Press / creator contact",
    },
    "JA": {
        "font": "Cradle-JA",
        "title": "プレス向けファクトシート",
        "locale": "日本語",
        "game_title": "生命の揺籃",
        "pitch": "生命の揺籃は、答えを求める歴戦の戦士カエリスが〈針〉を追うことになるダークファンタジー戦術RPGです。慎重なグリッド戦闘、目に見える結果を生む選択、そして道標に頼らない探索が、ソーンヴェイルでの旅を形作ります。",
        "facts_heading": "基本情報",
        "facts": [
            ("ジャンル", "ダークファンタジーRPG / 戦術RPG / ターン制戦術"),
            ("開発", "Garrett Mickelsen"),
            ("パブリッシャー", "Milo's Games"),
            ("対応OS", "Windows / macOS"),
            ("プレイ人数", "1人"),
            ("状況", "デモ配信中 / 発売予定"),
            ("デモ所要時間", "約1時間"),
            ("対応言語", "英語、日本語、韓国語、簡体字中国語、繁体字中国語"),
            ("エンジン", "RPG Maker MZ - 大幅にカスタマイズ"),
        ],
        "difference_heading": "本作ならではの特徴",
        "differences": [
            ("すべての行動に代償がある", "移動と攻撃は限られたAPを奪い合います。高低差、武器の間合い、地形、負傷、装備、均衡、恐怖、位置取りが毎ターンの判断を変えます。"),
            ("選択がゲームの進み方を変える", "選択は人々との関係、立ち入り可能な場所、その後の会話、そしてカエリスがどのような生存者になるかに影響します。六柱の神々はその理由を見ています。"),
            ("光る道標のない探索", "人々に問い、記録を読み、街道、家、洞窟、遺跡、森を調べて手掛かりを追います。その発見が、求めていた答えをより複雑にすることもあります。"),
        ],
        "demo": "STEAMで無料デモ配信中",
        "contact": "プレス / クリエイター窓口",
    },
    "KO": {
        "font": "Cradle-KO",
        "title": "프레스 팩트 시트",
        "locale": "한국어",
        "game_title": "생명의 요람",
        "pitch": "생명의 요람은 해답을 찾던 노련한 전사 카엘리스가 바늘을 추적하게 되는 다크 판타지 전술 RPG입니다. 신중한 그리드 전투, 눈에 보이는 결과를 남기는 선택, 표식에 의존하지 않는 탐험이 손베일에서의 여정을 결정합니다.",
        "facts_heading": "기본 정보",
        "facts": [
            ("장르", "다크 판타지 RPG / 전술 RPG / 턴제 전술"),
            ("개발", "Garrett Mickelsen"),
            ("퍼블리셔", "Milo's Games"),
            ("플랫폼", "Windows / macOS"),
            ("플레이 인원", "싱글 플레이"),
            ("상태", "데모 공개 / 출시 예정"),
            ("데모 플레이 시간", "약 1시간"),
            ("지원 언어", "영어, 일본어, 한국어, 중국어 간체, 중국어 번체"),
            ("엔진", "RPG Maker MZ - 대폭 커스터마이즈"),
        ],
        "difference_heading": "이 게임만의 특징",
        "differences": [
            ("모든 행동에는 비용이 따른다", "이동과 공격은 제한된 AP를 함께 사용합니다. 높이, 무기 사거리, 지형, 부상, 방어구, 균형, 공포, 위치 선정이 매 턴의 전술을 바꿉니다."),
            ("선택이 플레이 방식을 바꾼다", "선택은 사람들, 접근 가능한 장소, 이후 대화, 그리고 카엘리스가 어떤 생존자가 되는지에 영향을 줍니다. 서로 다른 여섯 신은 선택의 이유를 지켜봅니다."),
            ("빛나는 길표시 없는 탐험", "사람들에게 묻고 기록을 읽으며 길, 집, 동굴, 폐허, 숲을 조사해 단서를 찾습니다. 발견한 사실이 처음 찾던 답을 더 복잡하게 만들 수도 있습니다."),
        ],
        "demo": "STEAM 무료 데모 공개 중",
        "contact": "프레스 / 크리에이터 문의",
    },
    "ZH-CN": {
        "font": "Cradle-ZH-CN",
        "title": "媒体资料单",
        "locale": "简体中文",
        "game_title": "生命摇篮",
        "pitch": "生命摇篮是一款黑暗奇幻战术角色扮演游戏。久经沙场的战士凯利斯在寻找答案的过程中踏上了追寻「针」的旅途。审慎的网格战斗、带来可见后果的选择，以及没有发光路线指引的探索，共同塑造了索恩维尔的开篇旅程。",
        "facts_heading": "基本信息",
        "facts": [
            ("类型", "黑暗奇幻RPG / 战术RPG / 回合制战术"),
            ("开发者", "Garrett Mickelsen"),
            ("发行", "Milo's Games"),
            ("平台", "Windows / macOS"),
            ("玩家", "单人"),
            ("状态", "试玩版已上线 / 即将推出"),
            ("试玩时长", "约1小时"),
            ("语言", "英语、日语、韩语、简体中文、繁体中文"),
            ("引擎", "RPG Maker MZ - 深度定制"),
        ],
        "difference_heading": "独特之处",
        "differences": [
            ("每个行动都有代价", "移动和攻击共享有限的行动点。高低差、武器攻击距离、地形、伤势、护甲、架势、恐惧与站位都会改变每个回合。"),
            ("选择会改变玩法", "选择会影响人物、可进入的区域、后续对话，以及凯利斯最终成为怎样的幸存者。立场相悖的六位神明也在注视选择背后的理由。"),
            ("没有发光路线的探索", "玩家需要询问人物、阅读记录，并搜索道路、房屋、洞窟、遗迹与森林。找到的线索可能让原本寻求的答案变得更加复杂。"),
        ],
        "demo": "STEAM 免费试玩版",
        "contact": "媒体 / 创作者联系",
    },
    "ZH-TW": {
        "font": "Cradle-ZH-TW",
        "title": "媒體資料單",
        "locale": "繁體中文",
        "game_title": "生命搖籃",
        "pitch": "生命搖籃是一款黑暗奇幻戰術角色扮演遊戲。久經沙場的戰士凱利斯在尋找答案的過程中踏上了追尋「針」的旅途。審慎的網格戰鬥、帶來可見後果的選擇，以及沒有發光路線指引的探索，共同塑造了索恩維爾的開篇旅程。",
        "facts_heading": "基本資訊",
        "facts": [
            ("類型", "黑暗奇幻RPG / 戰術RPG / 回合制戰術"),
            ("開發者", "Garrett Mickelsen"),
            ("發行", "Milo's Games"),
            ("平台", "Windows / macOS"),
            ("玩家", "單人"),
            ("狀態", "試玩版已上線 / 即將推出"),
            ("試玩時長", "約1小時"),
            ("語言", "英語、日語、韓語、簡體中文、繁體中文"),
            ("引擎", "RPG Maker MZ - 深度客製"),
        ],
        "difference_heading": "獨特之處",
        "differences": [
            ("每個行動都有代價", "移動和攻擊共用有限的行動點。高低差、武器攻擊距離、地形、傷勢、護甲、架勢、恐懼與站位都會改變每個回合。"),
            ("選擇會改變玩法", "選擇會影響人物、可進入的區域、後續對話，以及凱利斯最終成為怎樣的倖存者。立場相悖的六位神明也在注視選擇背後的理由。"),
            ("沒有發光路線的探索", "玩家需要詢問人物、閱讀記錄，並搜尋道路、房屋、洞窟、遺跡與森林。找到的線索可能讓原本尋求的答案變得更加複雜。"),
        ],
        "demo": "STEAM 免費試玩版",
        "contact": "媒體 / 創作者聯絡",
    },
}


def wrap_text(text, font, size, max_width):
    tokens = text.split(" ") if " " in text else list(text)
    joiner = " " if " " in text else ""
    lines = []
    current = ""
    for token in tokens:
        candidate = token if not current else current + joiner + token
        if pdfmetrics.stringWidth(candidate, font, size) <= max_width:
            current = candidate
        else:
            if current:
                lines.append(current)
            current = token
    if current:
        lines.append(current)
    return lines


def draw_wrapped(c, text, x, y, width, font, size, leading, color=INK, max_lines=None):
    lines = wrap_text(text, font, size, width)
    if max_lines:
        lines = lines[:max_lines]
    c.setFillColor(color)
    c.setFont(font, size)
    for line in lines:
        c.drawString(x, y, line)
        y -= leading
    return y


def draw_qr(c, value, x, y, size):
    qr = QrCodeWidget(value)
    bounds = qr.getBounds()
    drawing = Drawing(size, size, transform=[size / (bounds[2] - bounds[0]), 0, 0, size / (bounds[3] - bounds[1]), 0, 0])
    drawing.add(qr)
    renderPDF.draw(drawing, c, x, y)


def build_sheet(code, data):
    OUTPUT.mkdir(parents=True, exist_ok=True)
    destination = OUTPUT / f"The_Cradle_of_Life_Fact_Sheet_{code}.pdf"
    c = canvas.Canvas(str(destination), pagesize=A4)
    c.setTitle(f"The Cradle of Life - {data['title']}")
    c.setAuthor("Milo's Games")
    c.setSubject("Official press fact sheet")

    c.setFillColor(PAPER)
    c.rect(0, 0, PAGE_W, PAGE_H, fill=1, stroke=0)
    c.setFillColor(DARK)
    c.rect(0, PAGE_H - 118, PAGE_W, 118, fill=1, stroke=0)
    c.setFillColor(RED)
    c.rect(0, PAGE_H - 123, PAGE_W, 5, fill=1, stroke=0)

    logo = ImageReader(str(LOGO))
    c.drawImage(logo, MARGIN, PAGE_H - 103, width=230, height=92, preserveAspectRatio=True, mask="auto", anchor="sw")
    c.setFillColor(HexColor("#f3e9df"))
    c.setFont(data["font"], 10)
    c.drawRightString(PAGE_W - MARGIN, PAGE_H - 43, data["title"])
    c.setFillColor(HexColor("#beaeb0"))
    c.setFont(data["font"], 8)
    c.drawRightString(PAGE_W - MARGIN, PAGE_H - 59, data["locale"])
    c.drawRightString(PAGE_W - MARGIN, PAGE_H - 76, "OFFICIAL PRESS MATERIALS")

    y = PAGE_H - 155
    c.setFillColor(RED)
    c.setFont(data["font"], 21)
    c.drawString(MARGIN, y, data["game_title"])
    y -= 20
    y = draw_wrapped(c, data["pitch"], MARGIN, y, PAGE_W - 2 * MARGIN, data["font"], 9.2, 13.2, INK, 4)

    y -= 9
    left_w = 224
    gap = 20
    right_x = MARGIN + left_w + gap
    right_w = PAGE_W - MARGIN - right_x
    panel_top = y
    panel_bottom = 327
    c.setFillColor(PANEL)
    c.roundRect(MARGIN, panel_bottom, left_w, panel_top - panel_bottom, 6, fill=1, stroke=0)
    c.setFillColor(RED)
    c.setFont(data["font"], 10)
    c.drawString(MARGIN + 14, panel_top - 22, data["facts_heading"])

    fy = panel_top - 42
    for label, value in data["facts"]:
        c.setFillColor(MUTED)
        c.setFont(data["font"], 6.8)
        c.drawString(MARGIN + 14, fy, label.upper() if code == "EN" else label)
        fy -= 9
        fy = draw_wrapped(c, value, MARGIN + 14, fy, left_w - 28, data["font"], 8.1, 10, INK, 2)
        fy -= 5

    c.setFillColor(VIOLET)
    c.setFont(data["font"], 10)
    c.drawString(right_x, panel_top - 12, data["difference_heading"])
    dy = panel_top - 37
    for index, (heading, body) in enumerate(data["differences"], 1):
        c.setFillColor(RED)
        c.circle(right_x + 9, dy + 3, 9, fill=1, stroke=0)
        c.setFillColor(PAPER)
        c.setFont("Helvetica-Bold", 8)
        c.drawCentredString(right_x + 9, dy, str(index))
        c.setFillColor(DARK)
        c.setFont(data["font"], 10)
        c.drawString(right_x + 27, dy, heading)
        dy -= 15
        dy = draw_wrapped(c, body, right_x + 27, dy, right_w - 27, data["font"], 8.2, 11, INK, 5)
        dy -= 15

    c.setStrokeColor(HexColor("#c8bdb5"))
    c.line(MARGIN, 302, PAGE_W - MARGIN, 302)

    qr_size = 76
    draw_qr(c, STEAM, MARGIN, 197, qr_size)
    c.setFillColor(RED)
    c.setFont(data["font"], 12)
    c.drawString(MARGIN + qr_size + 18, 257, data["demo"])
    c.setFillColor(INK)
    c.setFont("Helvetica", 7.8)
    c.drawString(MARGIN + qr_size + 18, 240, "store.steampowered.com/app/4580240")
    c.setFillColor(MUTED)
    c.setFont(data["font"], 8)
    c.drawString(MARGIN + qr_size + 18, 220, data["contact"])
    c.setFillColor(INK)
    c.setFont("Helvetica", 9)
    c.drawString(MARGIN + qr_size + 18, 205, PRESS_EMAIL)

    c.setFillColor(DARK)
    c.rect(0, 0, PAGE_W, 72, fill=1, stroke=0)
    c.setFillColor(HexColor("#f3e9df"))
    c.setFont("Helvetica", 8)
    c.drawString(MARGIN, 44, "THE CRADLE OF LIFE  |  MILO'S GAMES")
    c.setFillColor(HexColor("#bdaeb0"))
    c.setFont("Helvetica", 7)
    c.drawString(MARGIN, 28, "Official press materials - November 2026")
    c.drawRightString(PAGE_W - MARGIN, 44, "grmickelsen.github.io/Cradle-of-Life-Press-Kit/")

    c.showPage()
    c.save()
    return destination


if __name__ == "__main__":
    for locale_code, locale_data in CONTENT.items():
        print(build_sheet(locale_code, locale_data))
