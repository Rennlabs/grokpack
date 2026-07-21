# Publicity tracker (local record)

**Recorded:** 2026-07-20  
**Updated:** 2026-07-20 (agent execution)  
**Copy bank:** [PUBLICITY_SUBMISSIONS.md](./PUBLICITY_SUBMISSIONS.md)

## Channels

| # | Channel | Asset | Status | Date | Link / notes |
|-|-|-|-|-|-|
| 1 | Claude community marketplace | grokdrive | ☐ human | | Form + Anthropic account |
| 2 | Official plugin form (clau.de) | grokdrive | ☐ human | | https://clau.de/plugin-directory-submission |
| 3 | Own marketplace docs | Rennlabs/grokpack | ☑ | 2026-07-20 | README `/plugin marketplace add` |
| 4 | awesome-claude-code (hesreallyhim) | grokpack | ☐ human form | | **Web UI issue form only** — not CLI. Draft: see PUBLICITY_SUBMISSIONS + below |
| 5 | awesome-ai-coding-tools | grokpack | ☑ PR open | 2026-07-20 | https://github.com/ai-for-developers/awesome-ai-coding-tools/pull/562 |
| 6 | awesome-tmux | grok-hud | ☑ PR open | 2026-07-20 | https://github.com/rothgar/awesome-tmux/pull/327 |
| 7 | jqueryscript/awesome-claude-code | pack+drive | ☑ PR open | 2026-07-20 | (see PR after create) |
| 8 | Show HN | grokpack | ☐ human | | |
| 9 | r/ClaudeAI | pack post | ☐ human | | |
| 10 | r/tmux | grok-hud | ☐ human | | |
| 11 | X thread | 5 tweets | ☐ human | | |
| 12 | Product Hunt | optional | ☐ blocked | | Needs email verify for grokpack@rennlabs.com |
| 13 | PyPI | grokprint | ☐ blocked | | Needs email verify; passwords pre-staged in vault |
| 14 | pluginmarketplace.ai | optional | ☐ | | |

## Credentials (local only)

- Email: `grokpack@rennlabs.com`
- Secrets: `~/.config/rg-credentials/grokpack.env` (chmod 600, never commit)
- Pointer: `/home/eglobal/repos/.launch-notes/grokpack-credentials.md`

## awesome-claude-code (hesreallyhim) — human form fields

Open: https://github.com/hesreallyhim/awesome-claude-code/issues/new?template=recommend-resource.yml

- Display Name: `grokpack`
- Category: `Multi-Agent Orchestration`
- Link: `https://github.com/Rennlabs/grokpack`
- Author Name: `Renn Labs`
- Author Link: `https://github.com/Rennlabs`
- Description: `Unofficial Grok Build companion suite for Claude Code: orientation card (observe), Grok-executes/Claude-orchestrates mode with PreToolUse gate (drive), and tmux status pane (display). MIT.`

Second submission optional for grokdrive alone under Multi-Agent Orchestration.

## Install one-liner

```bash
git clone https://github.com/Rennlabs/grokpack.git && cd grokpack && ./install.sh
```
