# grokpack

> **Unofficial** — not affiliated with xAI. Best-effort companion suite for the
> Grok Build CLI; flags and component APIs may change without notice.

**The Grok Build companion suite for Claude Code — observe, drive, display.**

grokpack is a thin umbrella that installs, updates, and documents the
Grok-Build-specific tools. Each component is its own repo; this pack is the
front door. It does **not** bundle multi-engine fuse/route tools (fleet-fuse,
peer, etc.).

## The suite

| Component | Layer | What it does | Repo |
|-|-|-|-|
| **grokprint** | Observe | Turn-level orientation card (HAPPENED / ATTENTION / NEED) | [Rennlabs/grokprint](https://github.com/Rennlabs/grokprint) |
| **grokdrive** | Drive | Grok executes / Claude orchestrates + PreToolUse gate | [Rennlabs/grokdrive](https://github.com/Rennlabs/grokdrive) |
| **grok-hud** | Display | tmux status pane (`grok-hud`, `grok-with-hud`) | [Rennlabs/grok-hud](https://github.com/Rennlabs/grok-hud) |

## Install

```bash
git clone https://github.com/Rennlabs/grokpack.git
cd grokpack
./install.sh                 # suite CLI + all components
# or:
./install.sh --only print,hud
./install.sh --force         # backup foreign ~/.local/bin files first
./install.sh --suite-only    # only the grokpack CLI
./install.sh --dry-run
```

After install, the suite CLI is on `PATH` (via `~/.local/bin/grokpack`):

```bash
grokpack update              # pull + reinstall each component
grokpack status              # versions, paths, gate state
grokpack doctor              # aggregate health (exit = worst component)
grokpack uninstall           # reverse component installs
grokpack version
```

Resolution order per component: `GROKPACK_*_DIR` env → sibling under the parent
of this tree (`~/repos/grokprint`, …) → `git clone` from `Rennlabs/*`.

`grokpack.lock` pins component version@sha after install/update.

**Caveats:**

- grokdrive's gate arms only in Claude Code sessions started *after* install —
  start a fresh session, then `grokdrive on`.
- grokprint hooks reload in Grok via **Ctrl+L → Hooks → r**.
- If `~/.local/bin/grok-hud` is a plain file (old copy), use `./install.sh --force`.

## Which tool when?

Full map: [docs/routing.md](docs/routing.md).

| I want to … | Use |
|-|-|
| See what happened after a heavy Grok turn | **grokprint** |
| Keep a live status pane in tmux | **grok-hud** / **grok-with-hud** |
| Have Grok do the work under Claude's orchestration | **grokdrive** |
| Get a second opinion from Grok | **peer grok** |
| Fan a task across many engines | **fleet-fuse** / FrontierFuse |

## Where it sits

**grokpack** is the Grok-Build companion layer. Multi-engine orchestration
(fleet-fuse / FrontierFuse / peer) is a separate, cross-model layer.

## Plugin install

`.claude-plugin/marketplace.json` lists plugin-shaped components. **Draft —
validate against the current Claude Code marketplace schema.**

## License

MIT © 2026 Renn Labs
