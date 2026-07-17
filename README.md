# grokpack

> **Unofficial** — not affiliated with xAI. Best-effort companion suite for the
> Grok Build CLI; flags and component APIs may change without notice.

**The Grok Build companion suite for Claude Code — observe, drive, display.**

grokpack is a thin umbrella that installs and documents the Grok-Build-specific
tools. Each component is its own repo; this pack is the front door — suite
installer, plugin-marketplace manifest, and routing docs. It deliberately does
**not** bundle multi-engine fuse/route tools (fleet-fuse, peer, etc.) — those
are cross-model, not Grok-specific.

## The suite

| Component | Layer | What it does | Repo |
|-|-|-|-|
| **grokprint** | Observe | Turn-level orientation card (HAPPENED / ATTENTION / NEED) | [Rennlabs/grokprint](https://github.com/Rennlabs/grokprint) |
| **grokdrive** | Drive | Grok executes / Claude orchestrates + PreToolUse gate | [Rennlabs/grokdrive](https://github.com/Rennlabs/grokdrive) |
| **grok-hud** | Display | tmux status pane (`grok-hud`, `grok-with-hud`) | Vendored here (own repo TBD) |

`grok-hud` has no standalone repo yet; grokpack vendors the bins under `hud/`
until that lands.

## Install

```bash
git clone https://github.com/Rennlabs/grokpack.git
cd grokpack
./install.sh
```

Flags:

| Flag | Meaning |
|-|-|
| `--only print,drive,hud` | Install a subset (default = all three) |
| `--dry-run` | Print intended actions; mutate nothing |
| `--uninstall` | Reverse install for the selected components |

The suite installer:

1. Resolves each of `print` / `drive` via `GROKPACK_PRINT_DIR` / `GROKPACK_DRIVE_DIR`,
   else a sibling under the parent of this tree (e.g. a sibling `grokprint` checkout),
   else `git clone` from GitHub (`Rennlabs/grokprint`, `Rennlabs/grokdrive`).
2. Runs that component's own `install.sh` (symlink + settings wiring stay owned
   by the component).
3. For `hud`, symlinks the vendored bins into `~/.local/bin/` (idempotent; never
   clobbers a non-grokpack file).

If a clone fails (e.g. a component not published yet), that component is
skipped with a WARN — the rest of the suite still installs.

**Caveats after install:**

- grokdrive's gate arms only in Claude Code sessions started *after* install —
  start a fresh session, then `grokdrive on`.
- grokprint hooks reload in Grok via **Ctrl+L → Hooks → r**.

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

**grokpack** is the Grok-Build companion layer for Claude Code / OMC: observe
what Grok did, drive Grok under Claude's judgment, and display live status.
Multi-engine orchestration (fleet-fuse / FrontierFuse / peer / cc-composer-grok)
is a separate, cross-model layer that also happens to include Grok. grokpack
complements that layer; it does not replace or absorb it.

## Plugin install

`.claude-plugin/marketplace.json` lists the plugin-shaped components
(grokprint, grokdrive) by GitHub source. **Draft — validate against the current
Claude Code marketplace schema** before relying on marketplace install.

## Publishing / launch

Before publishing any component (or this umbrella), follow
[`docs/PUBLIC_LAUNCH_CHECKLIST.md`](docs/PUBLIC_LAUNCH_CHECKLIST.md). Creating
remotes, pushing, tagging, and making repos public are **human-gated**.

## License

MIT © 2026 Renn Labs
