# Changelog

## [0.2.0] - 2026-07-20

### Changed

- **grok-hud is its own component repo** ([Rennlabs/grok-hud](https://github.com/Rennlabs/grok-hud)). Suite installer treats `hud` like `print`/`drive` (sibling-first, `GROKPACK_HUD_DIR`, clone fallback).
- Removed vendored `hud/` bins from this umbrella (no longer ships script copies).

## [0.1.0] - 2026-07-19

Initial public release — umbrella for the Grok Build companion suite (observe / drive / display).

### Added

- Suite installer (`install.sh`): component-aware (`print`, `drive`, `hud`), sibling-first with clone fallback to `Rennlabs/*`, `--dry-run` / `--uninstall` / `--only`
- Plugin-marketplace manifest draft (`.claude-plugin/marketplace.json`)
- Routing docs (`docs/routing.md`) — observe vs drive vs multi-engine fuse
- Vendored `grok-hud` + `grok-with-hud` under `hud/` (later extracted to Rennlabs/grok-hud in 0.2.0)
- Standing public launch checklist (`docs/PUBLIC_LAUNCH_CHECKLIST.md`) — model-neutral, adapted from the Renn Labs public-release checklist
- `SECURITY.md`, `CONTRIBUTING.md`, `.github/workflows/ci.yml`
- README: unofficial / not affiliated with xAI note; Publishing / launch section
