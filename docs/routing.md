# Which Grok tool do I reach for?

Operator's decision map for the Grok Build companion suite and the multi-engine
layer that sits beside it. grokpack covers the Grok-specific tools (observe,
drive, display). Multi-engine fuse/route tools are documented here for
orientation only — they are not part of this pack.

## Three layers

### Observe (passive, safe)

| Tool | What it does |
|-|-|
| **grokprint** | After a tool-heavy Grok turn, glance at an orientation card (HAPPENED / ATTENTION / NEED FROM YOU) instead of scrolling the transcript. |
| **grok-hud** / **grok-with-hud** | Persistent tmux status pane for the live Grok session ([Rennlabs/grok-hud](https://github.com/Rennlabs/grok-hud)). |

Read-only. Neither tool drives agents or mutates project state. Reach for these
when you want visibility without changing who does the work.

### Drive (active, gated)

| Tool | What it does |
|-|-|
| **grokdrive** | Session mode: Grok 4.5 executes; Claude stays advisor-orchestrator. A hard PreToolUse gate blocks direct Claude Write/Edit while the mode is on. |

Use when you want Grok doing the work under Claude's judgment — burn Grok
credit, keep Claude as the planner/reviewer. The gate arms only in Claude Code
sessions started after install.

### Route / Fuse (multi-engine — not part of grokpack)

These tools also drive Codex, OpenRouter, Gemini, and other engines. They live
outside the Grok-branded pack; grokpack sits beside them and does not absorb them.

| Tool | What it does |
|-|-|
| **fleet-fuse** / **FrontierFuse** | Fan a task across many engines; can pin `--executor grok`. |
| **peer** | Second opinion: `peer grok`, `peer trio` (Claude + Codex + Grok). |
| **cc-composer-grok** | Composer-style multi-model routing that includes Grok. |

## Decision table

| I want to … | Use |
|-|-|
| See what happened after a heavy Grok turn | **grokprint** |
| Keep a live status pane in tmux | **grok-hud** / **grok-with-hud** |
| Have Grok do the work under Claude's orchestration | **grokdrive** |
| Get a second opinion from Grok | **peer grok** |
| Fan a task across many engines | **fleet-fuse** / FrontierFuse |

## Install path

Suite install (sibling-first, then clone):

```bash
./install.sh                  # all three
./install.sh --only print,hud
./install.sh --dry-run
```

Component installers own their own symlink and settings wiring. See the
[README](../README.md) for clone URLs and caveats.
