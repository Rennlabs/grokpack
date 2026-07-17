# Changelog

## [0.1.1] - 2026-07-16

### Added

- Standing public launch checklist (`docs/PUBLIC_LAUNCH_CHECKLIST.md`) —
  model-neutral, Grok-suite-scoped; adapted from the Renn Labs public-release checklist
- `SECURITY.md`, `CONTRIBUTING.md`
- `.github/workflows/ci.yml` (bash `-n`, marketplace JSON parse, shellcheck severity=error)
- `.omx/` and `.buildlog/` in `.gitignore`
- README: unofficial / not affiliated with xAI note; Publishing / launch section

## [0.1.0] - 2026-07-16

Initial umbrella release for the Grok Build companion suite (observe / drive / display).

- Suite installer (`install.sh`): component-aware (`print`, `drive`, `hud`), sibling-first with clone fallback to `Rennlabs/*`, `--dry-run` / `--uninstall` / `--only`
- Plugin-marketplace manifest draft (`.claude-plugin/marketplace.json`)
- Routing docs (`docs/routing.md`) — observe vs drive vs multi-engine fuse
- Vendored `grok-hud` + `grok-with-hud` under `hud/` (no standalone repo yet)
