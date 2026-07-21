# Publicity & inclusion — paste-ready copy

**Maintenance / placement registry:** [PUBLICITY_REGISTRY.md](./PUBLICITY_REGISTRY.md) (where listed + how to update)  
**Status checkboxes:** [PUBLICITY_TRACKER.md](./PUBLICITY_TRACKER.md)

**Suite:** grokpack (observe / drive / display) · **Org:** Renn Labs · **License:** MIT  
**Disclaimer (always include):** Unofficial — not affiliated with xAI or Anthropic.

| Repo | URL | Role |
|-|-|-|
| grokpack | https://github.com/Rennlabs/grokpack | Suite front door |
| grokprint | https://github.com/Rennlabs/grokprint | Observe |
| grokdrive | https://github.com/Rennlabs/grokdrive | Drive (Claude plugin-shaped) |
| grok-hud | https://github.com/Rennlabs/grok-hud | Display |

**Install one-liner (everywhere):**

```bash
git clone https://github.com/Rennlabs/grokpack.git && cd grokpack && ./install.sh
```

**Claude marketplace (after JSON is validated):**

```text
/plugin marketplace add Rennlabs/grokpack
```

---

## 1. Universal one-liner (bios, forms, “short description”)

**Short (≤160 chars):**  
Unofficial Grok Build companions for Claude Code — observe, drive, display. MIT. Not affiliated with xAI.

**Medium:**  
grokpack is an unofficial suite for Claude Code + Grok Build: grokprint (orientation card), grokdrive (Grok executes / Claude orchestrates + gate), grok-hud (tmux status). MIT · not affiliated with xAI or Anthropic.

**Tagline only:**  
Observe. Drive. Display. — Grok Build companions for Claude Code.

---

## 2. Claude community marketplace — submit **grokdrive**

Use for: community marketplace PR / submission form fields.

### Name
`grokdrive`

### Display title
grokdrive — Grok executes, Claude orchestrates

### One-line description
Session mode for Claude Code: Grok does the work; Claude stays advisor; a PreToolUse gate blocks direct Claude Write/Edit.

### Long description

```text
grokdrive is an unofficial Claude Code extension that implements a brain/body split:

- Claude (Opus / Fable / session model) plans, routes, reviews, and verifies
- Grok Build CLI executes headless on a self-contained spec
- A PreToolUse hook blocks Claude Write / Edit / MultiEdit / NotebookEdit while mode is ON

Install:
  git clone https://github.com/Rennlabs/grokdrive.git && cd grokdrive && ./install.sh
  # then start a FRESH Claude Code session, then: grokdrive on

Usage:
  grokdrive on | off | status | doctor | explain
  grokdrive "<self-contained implementation spec>"
  grokdrive verify --gate "pytest -q"

Important honesty:
  This is NOT a sandbox. Bash, MCP, and sub-agent writes are not blocked by the gate.
  Dispatches use Grok --always-approve by default (set GROKDRIVE_ALWAYS_APPROVE=0 to refuse).
  Unofficial — not affiliated with xAI or Anthropic. MIT.

Part of the grokpack suite: https://github.com/Rennlabs/grokpack
```

### Keywords / tags
`claude-code`, `grok`, `hooks`, `pretooluse`, `orchestration`, `mit`, `unofficial`

### Homepage
https://github.com/Rennlabs/grokdrive

### Source
https://github.com/Rennlabs/grokdrive

### License
MIT

### Author / org
Renn Labs · https://github.com/Rennlabs

### Security notes (for reviewers)

```text
- PreToolUse gate scopes only four Claude mutation tools; Bash is an intentional escape hatch (documented).
- Installer edits ~/.claude/settings.json with backup; aborts on invalid JSON.
- No telemetry. State under ~/.claude/.grokdrive-state/ (local).
- Gate denials and dispatches append to a local audit.jsonl.
- --always-approve is required for headless Grok; refuse path via GROKDRIVE_ALWAYS_APPROVE=0.
```

### Install verification steps (for reviewers)

```text
1. ./install.sh --dry-run
2. ./install.sh
3. Restart Claude Code
4. grokdrive doctor  → PASS
5. grokdrive on && grokdrive status  → shows ACTIVE + not-a-sandbox boundary
6. grokdrive off
```

---

## 3. Official Claude plugin directory form  
https://clau.de/plugin-directory-submission

### Plugin name
grokdrive

### GitHub repository URL
https://github.com/Rennlabs/grokdrive

### Short description (one sentence)
Burn-Grok-credit mode for Claude Code: Grok executes headless while Claude orchestrates, enforced by a PreToolUse gate on Write/Edit.

### Why this plugin (value prop)

```text
Many Claude Code users want to spend Grok capacity on implementation while keeping Claude for planning and review. grokdrive makes that split operational: one command to arm mode, a hard gate on Claude’s native edit tools, and a dispatcher that sends self-contained specs to the Grok Build CLI. Status/doctor/explain surface the real boundary (not a sandbox) so operators aren’t misled.
```

### Category (pick closest)
Agent orchestration / Workflow / Developer productivity

### Contact
(use your maintainer email)

### Additional notes

```text
Unofficial companion for Grok Build + Claude Code. Not affiliated with xAI or Anthropic.
Suite umbrella: https://github.com/Rennlabs/grokpack
Also ships as a suite component via: git clone https://github.com/Rennlabs/grokpack && ./install.sh
```

---

## 4. Suite marketplace blurb (grokpack README / docs / “add marketplace”)

### Title
Renn Labs — grokpack

### Description

```text
Unofficial Grok Build companion suite for Claude Code — observe (grokprint), drive (grokdrive), display (grok-hud). MIT. Not affiliated with xAI or Anthropic.
```

### Install

```text
/plugin marketplace add Rennlabs/grokpack
# or CLI suite:
git clone https://github.com/Rennlabs/grokpack.git && cd grokpack && ./install.sh
grokpack doctor
```

### Plugin list (for catalogs)

| Plugin | Description |
|-|-|
| grokprint | Observe: turn-level orientation card (HAPPENED / ATTENTION / NEED). Observer-only. |
| grokdrive | Drive: Grok executes / Claude orchestrates, enforced by a PreToolUse gate. |

*(grok-hud is suite CLI, not a Claude plugin — install via `./install.sh --only hud`.)*

---

## 5. Awesome-list PR templates

### 5a. awesome-claude-code (or similar Claude Code list)

**PR title:**  
Add grokpack — unofficial Grok Build companions for Claude Code

**PR body:**

```markdown
## Summary
Adds [grokpack](https://github.com/Rennlabs/grokpack), an unofficial suite of Grok Build companions for Claude Code (observe / drive / display).

## Checklist
- [x] Project is open source (MIT)
- [x] Link points to the main repository
- [x] Description is concise and accurate
- [x] Not affiliated with xAI / Anthropic (stated)

## Entry (suggested markdown)

### Claude Code + multi-model

- [grokpack](https://github.com/Rennlabs/grokpack) - Unofficial Grok Build companion suite for Claude Code: observe (orientation card), drive (Grok executes / Claude orchestrates + gate), display (tmux HUD). MIT.
```

**Bullet only (if they want one line):**

```markdown
- [grokpack](https://github.com/Rennlabs/grokpack) - Unofficial observe/drive/display companions for Grok Build + Claude Code (MIT).
```

### 5b. awesome-ai-coding-tools  
https://github.com/ai-for-developers/awesome-ai-coding-tools

**PR title:**  
Add grokpack (Grok + Claude Code companion suite)

**PR body:**

```markdown
Adds an open-source suite that pairs Claude Code with Grok Build:

- **grokprint** — turn-level orientation card (observer-only)
- **grokdrive** — Grok executes under Claude orchestration + PreToolUse gate
- **grok-hud** — tmux status pane

Suggested entry under CLI Tools / Coding Agents (adjacent):

- [grokpack](https://github.com/Rennlabs/grokpack) - Unofficial Grok Build companion suite for Claude Code (observe, drive, display). MIT.
```

### 5c. awesome-tmux

**PR title:**  
Add grok-hud — status pane for Grok Build sessions

**Entry:**

```markdown
- [grok-hud](https://github.com/Rennlabs/grok-hud) - Fixed-layout status pane for Grok Build / Claude harness sessions (`grok-with-hud` launcher). MIT.
```

### 5d. Generic “awesome terminal” / CLI list

```markdown
- [grokpack](https://github.com/Rennlabs/grokpack) - Install/update suite for Grok Build companions (print, drive, hud) aimed at Claude Code users.
```

---

## 6. Show HN (Hacker News)

**Title (≤80 chars):**  
Show HN: grokpack – observe/drive/display companions for Grok + Claude Code

**Text:**

```text
I built a small MIT suite for people who use Claude Code and the Grok Build CLI together:

- grokprint — after a tool-heavy Grok turn, show a short orientation card (HAPPENED / ATTENTION / NEED) instead of scrolling
- grokdrive — session mode where Grok executes and Claude stays the advisor; a PreToolUse gate blocks Claude Write/Edit (not a sandbox — Bash still can write; documented)
- grok-hud — tmux status pane (git / session / modes / verifier)

Front door:

  git clone https://github.com/Rennlabs/grokpack.git && cd grokpack && ./install.sh
  grokpack doctor

Unofficial — not affiliated with xAI or Anthropic. Feedback welcome, especially on install/update and the gate honesty UX.

https://github.com/Rennlabs/grokpack
```

---

## 7. Reddit

### 7a. r/ClaudeAI

**Title:**  
Unofficial suite: use Grok for execution while Claude orchestrates (plus orientation card + tmux HUD)

**Body:**

```markdown
Built a small open-source suite for Claude Code + Grok Build workflows.

**grokpack** (front door): https://github.com/Rennlabs/grokpack

| Layer | Tool | What it does |
|-|-|-|
| Observe | [grokprint](https://github.com/Rennlabs/grokprint) | Turn card: HAPPENED / ATTENTION / NEED FROM YOU |
| Drive | [grokdrive](https://github.com/Rennlabs/grokdrive) | Grok executes; Claude plans/reviews; PreToolUse gate on Write/Edit |
| Display | [grok-hud](https://github.com/Rennlabs/grok-hud) | tmux status pane |

```bash
git clone https://github.com/Rennlabs/grokpack.git && cd grokpack && ./install.sh
grokpack doctor
```

**Honest caveats**
- Unofficial — not affiliated with xAI or Anthropic
- grokdrive is **not** a sandbox (Bash/MCP can still write)
- Gate arms only after a **fresh** Claude Code session post-install

Happy to take feedback on the install/update story and gate UX.
```

### 7b. r/commandline or r/tmux (hud-focused)

**Title:**  
grok-hud — tmux status pane for Grok Build / agent sessions

**Body:**

```markdown
Small read-only status pane (git dirty, session, modes, last verifier) for people living in tmux with Grok/Claude harnesses.

https://github.com/Rennlabs/grok-hud

```bash
git clone https://github.com/Rennlabs/grok-hud.git && cd grok-hud && ./install.sh
grok-with-hud   # or: grok-hud --once
```

Part of a larger suite: https://github.com/Rennlabs/grokpack  
MIT · unofficial · no telemetry.
```

### 7c. r/LocalLLaMA (light touch — multi-model angle)

**Title:**  
Companion tools for splitting “brain” (Claude) vs “body” (Grok) in a terminal coding workflow

**Body:**  
(Reuse r/ClaudeAI body; stress multi-model orchestration and that multi-engine fuse tools stay separate.)

---

## 8. X / Twitter thread (paste sequence)

```text
1/5
Shipped grokpack — unofficial Grok Build companions for Claude Code: observe, drive, display.
MIT · not affiliated with xAI.
https://github.com/Rennlabs/grokpack

2/5
grokprint — after a tool-heavy Grok turn, glance at HAPPENED / ATTENTION / NEED instead of scrolling. Observer-only Stop hook.
https://github.com/Rennlabs/grokprint

3/5
grokdrive — Grok executes, Claude keeps the judgment. Session mode + PreToolUse gate on Claude Write/Edit.
(Not a sandbox — honesty in status/doctor.)
https://github.com/Rennlabs/grokdrive

4/5
grok-hud — persistent tmux status pane (git, session, modes, verifier). Launch with grok-with-hud.
https://github.com/Rennlabs/grok-hud

5/5
Install the suite:
git clone https://github.com/Rennlabs/grokpack.git
cd grokpack && ./install.sh
grokpack doctor
```

---

## 9. Product Hunt (optional)

**Name:**  
grokpack

**Tagline (≤60 chars):**  
Grok companions for Claude Code — observe, drive, display

**Description:**

```text
grokpack is an open-source suite for developers who use Claude Code and the Grok Build CLI together.

• grokprint — orientation card at the turn boundary (HAPPENED / ATTENTION / NEED)
• grokdrive — Grok does the work; Claude orchestrates; hard gate on Claude edit tools
• grok-hud — tmux status pane for live sessions

Unofficial · MIT · not affiliated with xAI or Anthropic.

Install: git clone https://github.com/Rennlabs/grokpack.git && cd grokpack && ./install.sh
```

**Topics:** Developer Tools, Open Source, Artificial Intelligence, Productivity  
**First comment:** paste Show HN text (shortened) + honest caveats.

---

## 10. pluginmarketplace.ai / claudepluginhub (if form fields)

**Name:** grokdrive (primary) / grokpack (suite)  
**Category:** Claude Code plugins / Agent orchestration  
**Website:** https://github.com/Rennlabs/grokpack  
**GitHub:** https://github.com/Rennlabs/grokdrive  
**Description:** same as marketplace long description above  
**Pricing:** Free / Open source (MIT)

---

## 11. PyPI (grokprint only — if you publish)

**Name:** `grokprint`  
**Summary:** Unofficial turn-level orientation print for Grok Build (HAPPENED / ATTENTION / NEED)  
**Description (long):**

```text
Unofficial observer-only orientation card for the Grok Build CLI.

After a tool-heavy turn, glance at:
  HAPPENED · ATTENTION · NEED FROM YOU

Install:
  pip install grokprint
  # wire hooks:
  git clone https://github.com/Rennlabs/grokprint.git && cd grokprint && ./install.sh
  # reload Grok hooks: Ctrl+L → Hooks → r

Not affiliated with xAI. Session formats may change. MIT.
```

**Keywords:** grok, claude-code, developer-tools, orientation, hooks  
**Project URLs:** Homepage → https://github.com/Rennlabs/grokprint · Suite → https://github.com/Rennlabs/grokpack

---

## 12. Email / cold outreach to list maintainers

**Subject:**  
OSS submission: grokpack — Grok companions for Claude Code (MIT)

**Body:**

```text
Hi —

I'd like to submit an open-source suite for inclusion if it fits your list:

  https://github.com/Rennlabs/grokpack

One line: unofficial Grok Build companions for Claude Code (observe / drive / display).

Components:
  grokprint  — orientation card (observer-only)
  grokdrive  — Grok executes / Claude orchestrates + PreToolUse gate
  grok-hud   — tmux status pane

MIT · no telemetry · not affiliated with xAI or Anthropic.

Happy to adjust the blurb to your format.

Thanks,
[Name]
Renn Labs
```

---

## 13. LinkedIn (short)

```text
Open-sourced grokpack — a small MIT suite for Claude Code + Grok Build:

• Observe with grokprint (turn orientation cards)
• Drive with grokdrive (Grok executes; Claude orchestrates; edit-tool gate)
• Display with grok-hud (tmux status)

Unofficial / not affiliated with xAI or Anthropic.

https://github.com/Rennlabs/grokpack
```

---

## 14. Submission tracker (checklist)

| Channel | Asset | Status |
|-|-|-|
| Claude community marketplace | grokdrive | ☐ |
| Official plugin form | grokdrive | ☐ |
| Own marketplace add | Rennlabs/grokpack | ☐ |
| awesome-claude-code (or equiv.) | grokpack | ☐ |
| awesome-ai-coding-tools | grokpack | ☐ |
| awesome-tmux | grok-hud | ☐ |
| Show HN | grokpack | ☐ |
| r/ClaudeAI | pack post | ☐ |
| r/tmux or r/commandline | grok-hud | ☐ |
| X thread | 5 tweets | ☐ |
| Product Hunt | optional | ☐ |
| PyPI | grokprint optional | ☐ |

---

## Disclaimer block (append anywhere legal/compliance asks)

```text
These tools are unofficial best-effort companions for the Grok Build CLI and Claude Code.
They are not affiliated with, endorsed by, or sponsored by xAI or Anthropic.
APIs, session formats, and CLI flags may change without notice and can break behavior.
License: MIT. No warranty.
```
