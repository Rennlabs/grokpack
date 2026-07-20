#!/usr/bin/env bash
# install.sh — suite installer for grokpack (thin umbrella)
#
# Installs the grokpack CLI + optional components (print/drive/hud).
# Prefer the suite CLI after install: grokpack install|update|status|doctor
set -euo pipefail

_SOURCE="${BASH_SOURCE[0]}"
while [[ -L "$_SOURCE" ]]; do
  _DIR="$(cd -P "$(dirname "$_SOURCE")" && pwd)"
  _SOURCE="$(readlink "$_SOURCE")"
  [[ "$_SOURCE" != /* ]] && _SOURCE="$_DIR/$_SOURCE"
done
REPO_ROOT="$(cd -P "$(dirname "$_SOURCE")" && pwd)"
unset _SOURCE _DIR

# shellcheck source=lib/install-common.sh
source "$REPO_ROOT/lib/install-common.sh"

HOME_DIR="${HOME:?HOME not set}"
BIN_DIR="${GROKPACK_BIN_DIR:-$HOME_DIR/.local/bin}"
DRY_RUN=0
UNINSTALL=0
FORCE=0
ONLY=""
SUITE_ONLY=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [OPTIONS]

Install grokpack suite CLI + components (print, drive, hud).

Options:
  --dry-run           Print actions; mutate nothing
  --uninstall         Reverse install
  --force             Backup foreign ~/.local/bin files before replacing
  --only <csv>        Components: print,drive,hud (default all three)
  --suite-only        Only install the grokpack CLI (no components)
  -h, --help          Show this help

After install, use:
  grokpack update | status | doctor | uninstall
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --uninstall) UNINSTALL=1; shift ;;
    --force) FORCE=1; shift ;;
    --suite-only) SUITE_ONLY=1; shift ;;
    --only)
      ONLY="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "install.sh: unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

log() { gp_log "$@"; }

# --- suite CLI symlink ---
if [[ "$UNINSTALL" -eq 1 ]]; then
  gp_safe_unlink "$BIN_DIR/grokpack" "$REPO_ROOT"
else
  chmod +x "$REPO_ROOT/bin/grokpack" "$REPO_ROOT/install.sh" 2>/dev/null || true
  gp_safe_symlink "$REPO_ROOT/bin/grokpack" "$BIN_DIR/grokpack" "$REPO_ROOT"
fi

if [[ "$SUITE_ONLY" -eq 1 ]]; then
  log "suite-only: grokpack CLI → $BIN_DIR/grokpack"
  exit 0
fi

# Delegate components to suite CLI (same logic)
flags=()
[[ "$DRY_RUN" -eq 1 ]] && flags+=(--dry-run)
[[ "$FORCE" -eq 1 ]] && flags+=(--force)
[[ -n "$ONLY" ]] && flags+=(--only "$ONLY")

if [[ "$UNINSTALL" -eq 1 ]]; then
  bash "$REPO_ROOT/bin/grokpack" uninstall "${flags[@]}"
else
  bash "$REPO_ROOT/bin/grokpack" install "${flags[@]}"
fi
