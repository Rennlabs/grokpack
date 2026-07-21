# Publicity registry & maintenance playbook

**Purpose:** single go-to for *where* the suite is listed/posted and *how* to update those surfaces when we ship changes.

**Last updated:** 2026-07-20  
**Owner:** Renn Labs · contact email for accounts: `grokpack@rennlabs.com`

---

## How to use this doc

| Situation | Open |
|-|-|
| Paste marketing / form copy | [PUBLICITY_SUBMISSIONS.md](./PUBLICITY_SUBMISSIONS.md) |
| Checkbox status of channels | [PUBLICITY_TRACKER.md](./PUBLICITY_TRACKER.md) |
| Pre-push quality gates | [PUBLIC_LAUNCH_CHECKLIST.md](./PUBLIC_LAUNCH_CHECKLIST.md) |
| **Where we’re listed + how to maintain** | **This file** |

After any **public release** of pack/print/drive/hud, run **§ Update playbook** below.

---

## 1. Canonical product facts (always update here first)

| Field | Value |
|-|-|
| Suite front door | https://github.com/Rennlabs/grokpack |
| Observe | https://github.com/Rennlabs/grokprint |
| Drive | https://github.com/Rennlabs/grokdrive |
| Display | https://github.com/Rennlabs/grok-hud |
| Org | [Rennlabs](https://github.com/Rennlabs) · display **Renn Labs** |
| License | MIT |
| Disclaimer | Unofficial — not affiliated with xAI or Anthropic |
| Install | `git clone https://github.com/Rennlabs/grokpack.git && cd grokpack && ./install.sh` |
| Suite CLI | `grokpack update` · `status` · `doctor` |
| Claude marketplace (draft) | `/plugin marketplace add Rennlabs/grokpack` |

**Version sources of truth (bump together on release):**

| Repo | Files to bump |
|-|-|
| grokpack | `VERSION`, `CHANGELOG.md`, GitHub Release tag, optionally `docs/*` |
| grokprint | `pyproject.toml` version, `src/grokprint/__init__.py` `__version__`, `CHANGELOG.md`, tag/release |
| grokdrive | `VERSION`, `.claude-plugin/plugin.json` `version`, `CHANGELOG.md`, tag/release |
| grok-hud | `VERSION`, `CHANGELOG.md`, tag/release |
| suite marketplace | `grokpack/.claude-plugin/marketplace.json` (descriptions if API/UX change) |

**Secrets / accounts (never in git):**

| Item | Location |
|-|-|
| Passwords / tokens for publicity accounts | `~/.config/rg-credentials/grokpack.env` (chmod 600) |
| Local pointer (no secrets) | `~/repos/.launch-notes/grokpack-credentials.md` |
| Email for new accounts | `grokpack@rennlabs.com` |

---

## 2. Placement registry

Status legend: **OPEN** = PR/issue waiting · **LIVE** = merged/published · **PENDING** = not submitted · **HUMAN** = requires maintainer browser/account · **BLOCKED** = missing dependency (email, etc.)

### 2.1 Own surfaces (we fully control)

| ID | Surface | URL / path | Status | What lives there | How to update |
|-|-|-|-|-|-|
| OWN-PACK | Suite README + docs | https://github.com/Rennlabs/grokpack | **LIVE** | Install, routing, publicity links | Edit `README.md`, `docs/*`, push `main` |
| OWN-PRINT | grokprint README | https://github.com/Rennlabs/grokprint | **LIVE** | Observe product page | Edit README/CHANGELOG; tag release |
| OWN-DRIVE | grokdrive README + plugin.json | https://github.com/Rennlabs/grokdrive | **LIVE** | Drive product + Claude plugin metadata | Bump `VERSION` + `.claude-plugin/plugin.json` + README; tag |
| OWN-HUD | grok-hud README | https://github.com/Rennlabs/grok-hud | **LIVE** | Display product | Bump `VERSION` + README; tag |
| OWN-RELEASES | GitHub Releases | pack [v0.2.0](https://github.com/Rennlabs/grokpack/releases) · print [v0.1.1](https://github.com/Rennlabs/grokprint/releases) · drive [v0.2.0](https://github.com/Rennlabs/grokdrive/releases) · hud [v0.1.0](https://github.com/Rennlabs/grok-hud/releases) | **LIVE** | Versioned artifacts / notes | `gh release create` / `edit` after tag; never leave notes stale vs tip |
| OWN-MARKET | Suite marketplace manifest | `grokpack/.claude-plugin/marketplace.json` | **LIVE (draft schema)** | Plugin list for Claude marketplaces | Edit JSON descriptions/repos; validate schema; announce in README |
| OWN-TOPICS | GitHub topics + homepage | each repo Settings/API | **LIVE** | Discoverability | `gh repo edit Rennlabs/<repo> --add-topic … --homepage …` |
| OWN-TRACKER | Publicity tracker | [PUBLICITY_TRACKER.md](./PUBLICITY_TRACKER.md) | **LIVE** | Channel checkboxes | Mark rows when status changes |
| OWN-COPY | Paste bank | [PUBLICITY_SUBMISSIONS.md](./PUBLICITY_SUBMISSIONS.md) | **LIVE** | Form/social drafts | Revise when tagline/install/UX changes |

### 2.2 Third-party directories & awesome lists

| ID | Channel | Asset listed | Status | Link | Maintainer update path |
|-|-|-|-|-|-|
| AW-TMUX | [rothgar/awesome-tmux](https://github.com/rothgar/awesome-tmux) | grok-hud | **OPEN** PR | https://github.com/rothgar/awesome-tmux/pull/327 | After merge: to change blurb → new PR to upstream (or comment on PR if still open). Fork: `Rennlabs/awesome-tmux` branch `add-grok-hud`. |
| AW-AI | [ai-for-developers/awesome-ai-coding-tools](https://github.com/ai-for-developers/awesome-ai-coding-tools) | grokpack | **OPEN** PR | https://github.com/ai-for-developers/awesome-ai-coding-tools/pull/562 | After merge: new PR for blurb/URL changes. Fork: `Rennlabs/awesome-ai-coding-tools` branch `add-grokpack`. |
| AW-CC-JQ | [jqueryscript/awesome-claude-code](https://github.com/jqueryscript/awesome-claude-code) | grokpack + grokdrive | **OPEN** PR | https://github.com/jqueryscript/awesome-claude-code/pull/521 | After merge: new PR. Fork: `Rennlabs/awesome-claude-code` branch `add-grokpack`. Star counts in list are static—update only if they re-scrape or we re-PR. |
| AW-CC-MAIN | [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | grokpack (intended) | **PENDING / HUMAN** | Form: [recommend-resource.yml](https://github.com/hesreallyhim/awesome-claude-code/issues/new?template=recommend-resource.yml) | **No PRs / no `gh` form.** Human web issue only. To “update”: open a new issue or comment if already listed; they control wording. Form fields: §2.4. |
| CL-COMM | Claude community marketplace | grokdrive | **PENDING / HUMAN** | Anthropic docs + community repo | Re-submit or PR per their process when hook/CLI UX changes; bump plugin version first. |
| CL-OFF | Official plugin directory form | grokdrive | **PENDING / HUMAN** | https://clau.de/plugin-directory-submission | Re-submit or follow Anthropic update process; keep `.claude-plugin/plugin.json` accurate. |
| DIR-PM | pluginmarketplace.ai / hubs | optional | **PENDING** | — | Edit listing in their UI; keep homepage = pack or drive. |
| PKG-PYPI | PyPI `grokprint` | not published yet | **BLOCKED** | — | When live: `twine upload` new versions; keep project description + home URL in sync. Creds in vault. |
| PH | Product Hunt | optional | **BLOCKED** | — | One-time launch; rarely “update”—post maker comment for major releases. |

### 2.3 Social / community posts (ephemeral)

These do not auto-update. On major releases, **re-post or reply** with the new tag + changelog link. Do not edit old HN/Reddit titles.

| ID | Channel | Status | When to touch again | How |
|-|-|-|-|-|
| SOC-HN | Show HN | **PENDING / HUMAN** | v0.3+ or big feature | New Show HN or comment on original with release link |
| SOC-R-CC | r/ClaudeAI | **PENDING / HUMAN** | notable release | New post or reply; link pack release notes |
| SOC-R-TMUX | r/tmux or r/commandline | **PENDING / HUMAN** | hud UX change | New post focused on hud |
| SOC-X | X thread | **PENDING / HUMAN** | any release | New thread or reply with tag URLs |
| SOC-LI | LinkedIn | **PENDING / HUMAN** | optional | Short post + pack URL |

Copy for all of the above: [PUBLICITY_SUBMISSIONS.md](./PUBLICITY_SUBMISSIONS.md).

### 2.4 Form fields to re-use (hesreallyhim)

| Field | Value |
|-|-|
| Display Name | `grokpack` |
| Category | `Multi-Agent Orchestration` |
| Link | `https://github.com/Rennlabs/grokpack` |
| Author Name | `Renn Labs` |
| Author Link | `https://github.com/Rennlabs` |
| Description | Unofficial Grok Build companion suite for Claude Code: orientation card (observe), Grok-executes/Claude-orchestrates mode with PreToolUse gate (drive), and tmux status pane (display). MIT. |

Optional second submission: **grokdrive** alone, same category, link `https://github.com/Rennlabs/grokdrive`.

---

## 3. Update playbook (run on every public release)

### 3.1 In-repo (required, agent-doable)

```text
1. Bump VERSION files + CHANGELOGs (all touched components).
2. Align .claude-plugin/plugin.json (grokdrive) + marketplace.json descriptions if UX changed.
3. Tag + gh release create/edit with honest notes.
4. Push main; confirm origin/main == tag tip.
5. Run docs/PUBLIC_LAUNCH_CHECKLIST.md gates (leak-scan, bash -n, dry-run).
6. Update this registry §2 if any placement status changed (OPEN→LIVE, new URL).
7. Tick PUBLICITY_TRACKER.md.
```

### 3.2 Third-party lists (after PRs merge)

| If listing is… | Action on suite change |
|-|-|
| **OPEN PR** (not merged) | Push amend to the fork branch **only if PR allows**; or comment on PR with updated blurb. Prefer leave alone until merged. |
| **LIVE on awesome-*** | Open a **small follow-up PR** only if: URL wrong, project renamed, description misleading, or project archived. **Do not** PR for every patch version. |
| **Form-only list** (hesreallyhim) | Comment on acceptance issue or re-recommend only for material product change. |
| **Claude marketplace** | Follow their plugin update rules; bump plugin version; reinstall path in README. |
| **PyPI** | Publish new version matching `pyproject.toml`; update long description if install changed. |

**Rule of thumb:** third-party awesome lists are **discovery**, not release notes. Point them at **grokpack**; keep detail on GitHub Releases.

### 3.3 Social

| Change type | Action |
|-|-|
| Patch (fix only) | No social required; optional X reply |
| Minor (user-visible feature) | X post + optional Reddit reply with release URL |
| Major / first launch | Full thread + Show HN + r/ClaudeAI (use paste bank) |

### 3.4 One-command status sweep (agent)

```bash
# PR statuses
gh pr view 327 --repo rothgar/awesome-tmux --json state,url
gh pr view 562 --repo ai-for-developers/awesome-ai-coding-tools --json state,url
gh pr view 521 --repo jqueryscript/awesome-claude-code --json state,url

# Own remotes clean?
for r in grokpack grokprint grokdrive grok-hud; do
  git -C ~/repos/$r status -sb
  git -C ~/repos/$r describe --tags --abbrev=0 2>/dev/null
done
```

After running, write results back into §2 tables and tracker.

---

## 4. What to change when product changes

| Product change | Update own surfaces | Update third-party? | Social? |
|-|-|-|-|
| Install path / flags | README all four + pack | Only if install one-liner in list blurb is wrong | Minor post if breaking |
| New component | pack README table + marketplace.json + this registry | New awesome PR if new class of tool | Yes |
| Rename repo/org | Everything + all LIVE listings ASAP | **Yes — urgent PRs** | Yes |
| Security/boundary wording (drive) | drive README, SECURITY, doctor strings | Only if list blurb claims “sandbox” | If correcting public misconception |
| Version bump only | CHANGELOG + Release | No | Optional |
| Deprecate tool | README tombstone + archive repo | PR to remove or mark unmaintained | Yes |

---

## 5. Fork / branch map (for re-PR)

| Upstream | Our fork | Branch | PR |
|-|-|-|-|
| rothgar/awesome-tmux | Rennlabs/awesome-tmux | `add-grok-hud` | #327 |
| ai-for-developers/awesome-ai-coding-tools | Rennlabs/awesome-ai-coding-tools | `add-grokpack` | #562 |
| jqueryscript/awesome-claude-code | Rennlabs/awesome-claude-code | `add-grokpack` | #521 |

To refresh an open PR:

```bash
cd /tmp && gh repo clone Rennlabs/<fork> && cd <fork>
git fetch upstream && git checkout <branch>
# edit README, commit, push origin <branch>
```

---

## 6. Roles: agent vs human

| Task | Agent (this environment) | Human (Erik) |
|-|-|-|
| Edit own repos, tags, releases | Yes | Approve policy |
| Open/update awesome PRs via `gh` | Yes (where PRs allowed) | Merge not controlled by us |
| hesreallyhim form | No (policy: web UI, human) | Yes |
| Claude marketplace forms | No | Yes |
| X / Reddit / HN / PH | No (accounts/captcha) | Yes |
| Create accounts with vault passwords | Partial (needs email receive) | Verify `grokpack@rennlabs.com` inbox |
| Keep this registry accurate | Yes — after every publicity action | Spot-check |

---

## 7. Changelog of publicity actions

| Date | Action | Result |
|-|-|-|
| 2026-07-20 | Shipped public repos + releases | All four LIVE on GitHub |
| 2026-07-20 | Created paste bank + tracker | docs/PUBLICITY_* |
| 2026-07-20 | Opened PR awesome-tmux #327 | OPEN |
| 2026-07-20 | Opened PR awesome-ai-coding-tools #562 | OPEN |
| 2026-07-20 | Opened PR jqueryscript awesome-claude-code #521 | OPEN |
| 2026-07-20 | Vault `~/.config/rg-credentials/grokpack.env` | Local only |
| 2026-07-20 | This registry created | Maintenance source of truth |

*(Append a row every time we submit, merge, or take down a listing.)*

---

## 8. Quick links

- Suite: https://github.com/Rennlabs/grokpack  
- Releases: https://github.com/Rennlabs/grokpack/releases  
- Routing: [routing.md](./routing.md)  
- Launch checklist: [PUBLIC_LAUNCH_CHECKLIST.md](./PUBLIC_LAUNCH_CHECKLIST.md)  
- Paste bank: [PUBLICITY_SUBMISSIONS.md](./PUBLICITY_SUBMISSIONS.md)  
- Tracker: [PUBLICITY_TRACKER.md](./PUBLICITY_TRACKER.md)  
- Multi-product marketing hub (FrontierFuse, shared playbook): `~/repos/marketing/`  
