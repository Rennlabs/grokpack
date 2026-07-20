#!/usr/bin/env bash
# install.sh — suite installer for grokpack (thin umbrella)
#
# Component-aware: installs print (grokprint), drive (grokdrive), and hud
# (grok-hud). Prefers sibling repos; falls back to clone from GitHub.
#
# Usage:
#   ./install.sh                    # install all three (idempotent)
#   ./install.sh --dry-run          # print actions; mutate nothing
#   ./install.sh --uninstall        # reverse install
#   ./install.sh --only print,hud   # subset of components
#   ./install.sh -h|--help
set -euo pipefail

# Resolve REPO_ROOT as the directory containing this script (symlink-safe).
_SOURCE="${BASH_SOURCE[0]}"
while [[ -L "$_SOURCE" ]]; do
  _DIR="$(cd -P "$(dirname "$_SOURCE")" && pwd)"
  _SOURCE="$(readlink "$_SOURCE")"
  [[ "$_SOURCE" != /* ]] && _SOURCE="$_DIR/$_SOURCE"
done
REPO_ROOT="$(cd -P "$(dirname "$_SOURCE")" && pwd)"
unset _SOURCE _DIR

HOME_DIR="${HOME:?HOME not set}"
SIBLING_PARENT="$(dirname "$REPO_ROOT")"

PRINT_REPO="https://github.com/Rennlabs/grokprint.git"
DRIVE_REPO="https://github.com/Rennlabs/grokdrive.git"
HUD_REPO="https://github.com/Rennlabs/grok-hud.git"

DRY_RUN=0
UNINSTALL=0
ONLY=""

usage() {
  cat <<'EOF'
Usage: ./install.sh [OPTIONS]

Suite installer for grokpack — the Grok Build companion suite (observe / drive / display).

Components:
  print   grokprint  (orientation card; sibling or clone Rennlabs/grokprint)
  drive   grokdrive  (Grok-executes / Claude-orchestrates + gate)
  hud     grok-hud   (tmux status pane; sibling or clone Rennlabs/grok-hud)

Options:
  --dry-run           Print every action; mutate nothing
  --uninstall         Reverse install for selected components
  --only <csv>        Subset, e.g. print,hud  (default: print,drive,hud)
  -h, --help          Show this help

Install prefers GROKPACK_PRINT_DIR / GROKPACK_DRIVE_DIR / GROKPACK_HUD_DIR,
then sibling repos under the parent of this tree (e.g. ~/repos/grokprint),
then clones from GitHub. Each component's own install.sh owns symlink +
settings wiring.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --uninstall) UNINSTALL=1; shift ;;
    --only)
      if [[ $# -lt 2 ]]; then
        echo "install.sh: --only requires a comma-separated list" >&2
        exit 2
      fi
      ONLY="$2"
      shift 2
      ;;
    -h|--help) usage; exit 0 ;;
    *) echo "install.sh: unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

# Default component set
if [[ -z "$ONLY" ]]; then
  ONLY="print,drive,hud"
fi

log() { printf '%s\n' "$*"; }
warn() { printf 'WARN: %s\n' "$*" >&2; }

# Parse ONLY into a space-separated list of valid names
COMPONENTS=()
_IFS_OLD="$IFS"
IFS=','
for _c in $ONLY; do
  _c="${_c// /}"
  case "$_c" in
    print|drive|hud) COMPONENTS+=("$_c") ;;
    "") ;;
    *) echo "install.sh: unknown component in --only: $_c (want print, drive, or hud)" >&2; exit 2 ;;
  esac
done
IFS="$_IFS_OLD"
unset _c _IFS_OLD

if [[ ${#COMPONENTS[@]} -eq 0 ]]; then
  echo "install.sh: no components selected" >&2
  exit 2
fi

# Track outcomes for the final summary
declare -A OUTCOME

# --- locate or clone a sibling component repo ---
# Args: name, env_var_name, default_dir_name, clone_url
# Sets global LOCATED_DIR on success; returns 0/1.
locate_component() {
  local name="$1" env_var="$2" dir_name="$3" clone_url="$4"
  local override="${!env_var:-}"
  local sibling="$SIBLING_PARENT/$dir_name"
  LOCATED_DIR=""

  if [[ -n "$override" ]]; then
    if [[ -d "$override" && -f "$override/install.sh" ]]; then
      LOCATED_DIR="$(cd -P "$override" && pwd)"
      return 0
    fi
    warn "$name: $env_var=$override is set but has no install.sh — skipping"
    return 1
  fi

  if [[ -d "$sibling" && -f "$sibling/install.sh" ]]; then
    LOCATED_DIR="$(cd -P "$sibling" && pwd)"
    return 0
  fi

  # Need to clone
  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "[dry-run] would git clone $clone_url $sibling"
    log "[dry-run] would run $sibling/install.sh --dry-run"
    LOCATED_DIR="$sibling"  # notional
    return 0
  fi

  log "clone: $clone_url → $sibling"
  if git clone "$clone_url" "$sibling"; then
    if [[ -f "$sibling/install.sh" ]]; then
      LOCATED_DIR="$(cd -P "$sibling" && pwd)"
      return 0
    fi
    warn "$name: clone succeeded but $sibling/install.sh missing — skipping"
    return 1
  fi

  warn "$name: git clone failed (repo may not be published yet) — skipping"
  return 1
}

run_component_installer() {
  local name="$1" dir="$2"

  if [[ "$DRY_RUN" -eq 1 ]]; then
    # Prefer printing intent only (component --dry-run is also non-mutating;
    # we keep dry-run fully local to this script for simplicity).
    if [[ "$UNINSTALL" -eq 1 ]]; then
      log "[dry-run] would run $dir/install.sh --dry-run --uninstall"
    else
      log "[dry-run] would run $dir/install.sh --dry-run"
    fi
    return 0
  fi

  local cmd=(bash "$dir/install.sh")
  [[ "$UNINSTALL" -eq 1 ]] && cmd+=(--uninstall)
  log "→ ${cmd[*]}"
  "${cmd[@]}"
}

install_or_skip() {
  local name="$1" env_var="$2" dir_name="$3" clone_url="$4"
  local action="install"
  [[ "$UNINSTALL" -eq 1 ]] && action="uninstall"

  if locate_component "$name" "$env_var" "$dir_name" "$clone_url"; then
    if [[ "$DRY_RUN" -eq 1 && ! -d "${LOCATED_DIR:-}" ]]; then
      OUTCOME[$name]="would $action (clone then install)"
      return 0
    fi
    if run_component_installer "$name" "$LOCATED_DIR"; then
      OUTCOME[$name]="$action via $LOCATED_DIR"
    else
      OUTCOME[$name]="FAILED $action via $LOCATED_DIR"
      return 1
    fi
  else
    OUTCOME[$name]="skipped (not found / clone failed)"
  fi
}

do_print() { install_or_skip print GROKPACK_PRINT_DIR grokprint "$PRINT_REPO"; }
do_drive() { install_or_skip drive GROKPACK_DRIVE_DIR grokdrive "$DRIVE_REPO"; }
do_hud()   { install_or_skip hud   GROKPACK_HUD_DIR   grok-hud  "$HUD_REPO"; }

# --- main ---
log "grokpack suite installer"
log "  REPO_ROOT=$REPO_ROOT"
log "  components: ${COMPONENTS[*]}"
[[ "$DRY_RUN" -eq 1 ]] && log "  mode: dry-run (no mutations)"
[[ "$UNINSTALL" -eq 1 ]] && log "  mode: uninstall"
log ""

for c in "${COMPONENTS[@]}"; do
  case "$c" in
    print) do_print ;;
    drive) do_drive ;;
    hud) do_hud ;;
  esac
done

log ""
log "=== grokpack summary ==="
for c in "${COMPONENTS[@]}"; do
  log "  $c: ${OUTCOME[$c]:-unknown}"
done

if [[ "$UNINSTALL" -eq 0 ]]; then
  log ""
  log "Caveats:"
  log "  • grokdrive's PreToolUse gate arms only in Claude Code sessions started"
  log "    after install — start a fresh session, then run: grokdrive on"
  log "  • grokprint hooks reload in Grok via Ctrl+L → Hooks → r"
fi

log ""
log "done."
