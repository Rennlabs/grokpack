# Changelog

## [0.2.0] - 2026-07-20

### Added

- Suite CLI `bin/grokpack`: `install` / `update` / `status` / `doctor` / `uninstall` / `version`
- Shared `lib/install-common.sh` (no-clobber symlink + `--force` backup)
- `grokpack.lock` pin file (version@sha) written on install/update
- `VERSION` file; `--force` and `--suite-only` on `install.sh`

### Changed

- **grok-hud** is a first-class component ([Rennlabs/grok-hud](https://github.com/Rennlabs/grok-hud)); vendored `hud/` removed
- Installer resolves `GROKPACK_HUD_DIR` / sibling / clone like print and drive

## [0.1.0] - 2026-07-19

Initial public release — umbrella for the Grok Build companion suite (observe / drive / display).
