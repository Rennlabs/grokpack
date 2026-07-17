#!/usr/bin/env bash
# install.sh — suite installer for grokpack (thin umbrella)
#
# Component-aware: installs print (grokprint), drive (grokdrive), and hud
# (vendored bins). Prefers sibling repos; falls back to clone from GitHub.
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
BIN_DIR="$HOME_DIR/.local/bin"

PRINT_REPO="https://github.com/Rennlabs/grokprint.git"
DRIVE_REPO="https://github.com/Rennlabs/grokdrive.git"

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
  hud     vendored grok-hud + grok-with-hud → ~/.local/bin

Options:
  --dry-run           Print every action; mutate nothing
  --uninstall         Reverse install for selected components
  --only <csv>        Subset, e.g. print,hud  (default: print,drive,hud)
  -h, --help          Show this help

Install prefers GROKPACK_PRINT_DIR / GROKPACK_DRIVE_DIR, then sibling
repos under the parent of this tree (e.g. ~/repos/grokprint), then clones
from GitHub. Each component's own install.sh owns symlink + settings wiring.
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
# Args: name (print|drive), env_var_name, default_dir_name, clone_url
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

# --- hud: symlink vendored bins ---
_realpath() {
  if command -v realpath >/dev/null 2>&1; then
    realpath -m "$1" 2>/dev/null || echo "$1"
  else
    # portable fallback
    (cd "$(dirname "$1")" 2>/dev/null && echo "$(pwd)/$(basename "$1")") || echo "$1"
  fi
}

install_hud_link() {
  local src="$1" name="$2"
  local dst="$BIN_DIR/$name"
  local src_real
  src_real="$(_realpath "$src")"

  if [[ ! -f "$src" ]]; then
    warn "hud: missing vendored bin $src — skip $name"
    return 1
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "[dry-run] would mkdir -p $BIN_DIR"
    log "[dry-run] would symlink $src → $dst"
    return 0
  fi

  mkdir -p "$BIN_DIR"

  if [[ -L "$dst" ]]; then
    local cur
    cur="$(readlink "$dst")"
    local cur_real
    cur_real="$(_realpath "$cur")"
    # if relative link, resolve against BIN_DIR
    if [[ "$cur" != /* ]]; then
      cur_real="$(_realpath "$BIN_DIR/$cur")"
    fi
    if [[ "$cur_real" == "$src_real" ]]; then
      log "hud: $name already linked (ok)"
      return 0
    fi
    # Only replace if it already points into this repo
    if [[ "$cur_real" == "$REPO_ROOT"/* ]]; then
      ln -sfn "$src" "$dst"
      log "hud: updated $dst → $src"
      return 0
    fi
    warn "hud: $dst exists and is not a grokpack link (points to $cur) — not clobbering"
    return 1
  fi

  if [[ -e "$dst" ]]; then
    warn "hud: $dst exists and is not a symlink — not clobbering"
    return 1
  fi

  ln -s "$src" "$dst"
  log "hud: linked $dst → $src"
  return 0
}

uninstall_hud_link() {
  local src="$1" name="$2"
  local dst="$BIN_DIR/$name"
  local src_real
  src_real="$(_realpath "$src")"

  if [[ ! -e "$dst" && ! -L "$dst" ]]; then
    log "hud: $name not installed (ok)"
    return 0
  fi

  if [[ ! -L "$dst" ]]; then
    warn "hud: $dst is not a symlink — leaving it alone"
    return 1
  fi

  local cur cur_real
  cur="$(readlink "$dst")"
  if [[ "$cur" != /* ]]; then
    cur_real="$(_realpath "$BIN_DIR/$cur")"
  else
    cur_real="$(_realpath "$cur")"
  fi

  # Only remove if it points into this repo (or exactly to our vendored bin)
  if [[ "$cur_real" == "$src_real" || "$cur_real" == "$REPO_ROOT"/* ]]; then
    if [[ "$DRY_RUN" -eq 1 ]]; then
      log "[dry-run] would rm $dst"
      return 0
    fi
    rm -f "$dst"
    log "hud: removed $dst"
    return 0
  fi

  warn "hud: $dst points outside grokpack ($cur) — not removing"
  return 1
}

do_print() {
  local action="install"
  [[ "$UNINSTALL" -eq 1 ]] && action="uninstall"
  if locate_component print GROKPACK_PRINT_DIR grokprint "$PRINT_REPO"; then
    if [[ "$DRY_RUN" -eq 1 && ! -d "${LOCATED_DIR:-}" ]]; then
      OUTCOME[print]="would $action (clone then install)"
      return 0
    fi
    if run_component_installer print "$LOCATED_DIR"; then
      OUTCOME[print]="$action via $LOCATED_DIR"
    else
      OUTCOME[print]="FAILED $action via $LOCATED_DIR"
      return 1
    fi
  else
    OUTCOME[print]="skipped (not found / clone failed)"
  fi
}

do_drive() {
  local action="install"
  [[ "$UNINSTALL" -eq 1 ]] && action="uninstall"
  if locate_component drive GROKPACK_DRIVE_DIR grokdrive "$DRIVE_REPO"; then
    if [[ "$DRY_RUN" -eq 1 && ! -d "${LOCATED_DIR:-}" ]]; then
      OUTCOME[drive]="would $action (clone then install)"
      return 0
    fi
    if run_component_installer drive "$LOCATED_DIR"; then
      OUTCOME[drive]="$action via $LOCATED_DIR"
    else
      OUTCOME[drive]="FAILED $action via $LOCATED_DIR"
      return 1
    fi
  else
    OUTCOME[drive]="skipped (not found / clone failed)"
  fi
}

do_hud() {
  local action="install"
  [[ "$UNINSTALL" -eq 1 ]] && action="uninstall"
  local ok=0
  if [[ "$UNINSTALL" -eq 1 ]]; then
    uninstall_hud_link "$REPO_ROOT/hud/grok-hud" grok-hud && ok=$((ok + 1)) || true
    uninstall_hud_link "$REPO_ROOT/hud/grok-with-hud" grok-with-hud && ok=$((ok + 1)) || true
  else
    install_hud_link "$REPO_ROOT/hud/grok-hud" grok-hud && ok=$((ok + 1)) || true
    install_hud_link "$REPO_ROOT/hud/grok-with-hud" grok-with-hud && ok=$((ok + 1)) || true
  fi
  if [[ "$ok" -eq 2 ]]; then
    OUTCOME[hud]="$action grok-hud + grok-with-hud → $BIN_DIR"
  elif [[ "$ok" -gt 0 ]]; then
    OUTCOME[hud]="$action partial ($ok/2 bins)"
  else
    OUTCOME[hud]="$action failed / skipped"
  fi
}

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
