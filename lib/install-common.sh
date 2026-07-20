#!/usr/bin/env bash
# install-common.sh — shared install primitives for the grokpack suite.
#
# Source from a component install.sh:
#   # shellcheck source=lib/install-common.sh
#   source "$(cd "$(dirname "$0")" && pwd)/lib/install-common.sh"
# or, when vendored/copied into a component:
#   source "$REPO_ROOT/lib/install-common.sh"
#
# Expects caller may set: DRY_RUN=0|1, FORCE=0|1
# Provides: gp_log, gp_warn, gp_realpath, gp_safe_symlink, gp_safe_unlink,
#           gp_git_sha, gp_component_version
set -euo pipefail

: "${DRY_RUN:=0}"
: "${FORCE:=0}"

gp_log() { printf '%s\n' "$*"; }
gp_warn() { printf 'WARN: %s\n' "$*" >&2; }

gp_realpath() {
  local p="${1:-}"
  if command -v realpath >/dev/null 2>&1; then
    realpath -m "$p" 2>/dev/null || echo "$p"
  else
    python3 -c 'import os,sys; print(os.path.realpath(sys.argv[1]))' "$p" 2>/dev/null || echo "$p"
  fi
}

# True if path is a symlink whose ultimate target is under $1 (root).
gp_points_into() {
  local path="$1" root="$2"
  [[ -L "$path" ]] || return 1
  local target r
  target="$(gp_realpath "$path")"
  r="$(gp_realpath "$root")"
  [[ "$target" == "$r"/* || "$target" == "$r" ]]
}

# Safe symlink with optional backup of foreign files when FORCE=1.
# Args: src dst [repo_root]
# If dst exists as a non-symlink or foreign symlink:
#   FORCE=0 -> warn + skip
#   FORCE=1 -> backup to dst.bak.<timestamp> then link
gp_safe_symlink() {
  local src="$1" dst="$2" root="${3:-}"
  local dst_dir
  dst_dir="$(dirname "$dst")"

  if [[ ! -e "$src" ]]; then
    echo "install: ERROR: source missing: $src" >&2
    return 1
  fi

  if [[ -L "$dst" ]]; then
    if [[ -n "$root" ]] && gp_points_into "$dst" "$root"; then
      local cur want
      cur="$(gp_realpath "$dst")"
      want="$(gp_realpath "$src")"
      if [[ "$cur" == "$want" ]]; then
        gp_log "  already linked: $dst -> $src"
        return 0
      fi
      gp_log "  re-link: $dst -> $src"
      if [[ "$DRY_RUN" -eq 1 ]]; then
        gp_log "[dry-run] rm -f $dst && ln -s $src $dst"
      else
        rm -f "$dst"
        ln -s "$src" "$dst"
      fi
      return 0
    fi
    if [[ "$FORCE" -eq 1 ]]; then
      _gp_backup_and_link "$src" "$dst" "$dst_dir"
      return 0
    fi
    gp_warn "$dst points elsewhere ($(readlink "$dst")); skip (use --force to backup+replace)"
    return 0
  fi

  if [[ -e "$dst" ]]; then
    if [[ "$FORCE" -eq 1 ]]; then
      _gp_backup_and_link "$src" "$dst" "$dst_dir"
      return 0
    fi
    gp_warn "$dst exists and is not a symlink; skip (use --force to backup+replace)"
    return 0
  fi

  gp_log "  ln -s $src $dst"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    gp_log "[dry-run] mkdir -p $dst_dir && ln -s $src $dst"
  else
    mkdir -p "$dst_dir"
    ln -s "$src" "$dst"
  fi
}

_gp_backup_and_link() {
  local src="$1" dst="$2" dst_dir="$3"
  local bak="${dst}.bak.$(date -u +%Y%m%dT%H%M%SZ)"
  gp_log "  backup: $dst -> $bak"
  gp_log "  ln -s $src $dst"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    gp_log "[dry-run] mv $dst $bak && ln -s $src $dst"
    return 0
  fi
  mkdir -p "$dst_dir"
  mv "$dst" "$bak"
  ln -s "$src" "$dst"
}

# Remove symlink only if it points into repo_root.
gp_safe_unlink() {
  local dst="$1" root="$2"
  if [[ ! -e "$dst" && ! -L "$dst" ]]; then
    gp_log "  not present: $dst"
    return 0
  fi
  if [[ -L "$dst" ]] && gp_points_into "$dst" "$root"; then
    gp_log "  rm $dst"
    if [[ "$DRY_RUN" -eq 1 ]]; then
      gp_log "[dry-run] rm -f $dst"
    else
      rm -f "$dst"
    fi
    return 0
  fi
  if [[ -L "$dst" ]]; then
    gp_warn "$dst points outside repo; leave in place"
    return 0
  fi
  gp_warn "$dst is not a managed symlink; leave in place"
}

gp_git_sha() {
  local dir="${1:-.}"
  git -C "$dir" rev-parse --short HEAD 2>/dev/null || echo "unknown"
}

gp_component_version() {
  local dir="$1"
  if [[ -f "$dir/VERSION" ]]; then
    tr -d ' \n' <"$dir/VERSION"
    return
  fi
  if [[ -f "$dir/pyproject.toml" ]]; then
    python3 - "$dir/pyproject.toml" 2>/dev/null <<'PY' || true
import re,sys
t=open(sys.argv[1]).read()
m=re.search(r'^version\s*=\s*"([^"]+)"', t, re.M)
print(m.group(1) if m else "")
PY
    return
  fi
  echo "0.0.0-dev"
}
