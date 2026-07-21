# Publicity tracker

**Compendium (where + how to maintain):** [PUBLICITY_REGISTRY.md](./PUBLICITY_REGISTRY.md)  
**Paste-ready copy:** [PUBLICITY_SUBMISSIONS.md](./PUBLICITY_SUBMISSIONS.md)  
**Last status sweep:** 2026-07-20

Mark channels when submitted/merged. Do not invent “done” without a real URL.

## Status

| # | Channel | Asset | Status | Date | Link / notes |
|-|-|-|-|-|-|
| 1 | Claude community marketplace | grokdrive | ☐ HUMAN | | Anthropic account + form |
| 2 | Official plugin form | grokdrive | ☐ HUMAN | | https://clau.de/plugin-directory-submission |
| 3 | Own marketplace docs | pack | ☑ LIVE | 2026-07-20 | README `/plugin marketplace add` |
| 4 | hesreallyhim/awesome-claude-code | pack | ☐ HUMAN form | | Web issue only — fields in REGISTRY §2.4 |
| 5 | awesome-ai-coding-tools | pack | ☑ OPEN PR | 2026-07-20 | https://github.com/ai-for-developers/awesome-ai-coding-tools/pull/562 |
| 6 | awesome-tmux | hud | ☑ OPEN PR | 2026-07-20 | https://github.com/rothgar/awesome-tmux/pull/327 |
| 7 | jqueryscript/awesome-claude-code | pack+drive | ☑ OPEN PR | 2026-07-20 | https://github.com/jqueryscript/awesome-claude-code/pull/521 |
| 8 | Show HN | pack | ☐ HUMAN | | Copy in SUBMISSIONS §6 |
| 9 | r/ClaudeAI | pack | ☐ HUMAN | | SUBMISSIONS §7a |
| 10 | r/tmux | hud | ☐ HUMAN | | SUBMISSIONS §7b |
| 11 | X thread | suite | ☐ HUMAN | | SUBMISSIONS §8 |
| 12 | Product Hunt | optional | ☐ BLOCKED | | Email verify; vault ready |
| 13 | PyPI grokprint | optional | ☐ BLOCKED | | Email verify; vault ready |
| 14 | pluginmarketplace.ai | optional | ☐ | | |

## After a release — minimum maintenance

1. Follow **PUBLICITY_REGISTRY.md §3 Update playbook**.  
2. Sweep open PRs (`gh pr view …`); if **MERGED**, set status → LIVE and add registry changelog row.  
3. If install one-liner or product name changed, open follow-up PRs only for **LIVE** lists with wrong blurb.  
4. Append action to registry §7.

## Credentials (local only)

- Email: `grokpack@rennlabs.com`  
- Secrets: `~/.config/rg-credentials/grokpack.env` (chmod 600, never commit)  
- Pointer: `~/repos/.launch-notes/grokpack-credentials.md`  
