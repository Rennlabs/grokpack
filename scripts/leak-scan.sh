#!/usr/bin/env bash
# leak-scan.sh — scan tracked files for private paths / emails / token shapes.
# Report file:line only; never echo matched secret values beyond the line context
# git grep already shows. Exit 0 if clean, 1 if hits.
set -euo pipefail
# Build pattern from pieces so this script is not itself a false positive.
_home='/home/''[a-z]+'
_mail='@''gmail|@''rennlabs'
_ip='[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
_tok='sk-''[A-Za-z0-9]{10,}|ghp_''[A-Za-z0-9]{20,}|xai-''[A-Za-z0-9]{10,}'
_pat="${_home}|${_mail}|${_ip}|${_tok}"
if git grep -nIE "${_pat}"; then
  echo "leak-scan: HITS (file/line above — investigate; rotate if real credential)" >&2
  exit 1
fi
echo "leak-scan: clean"
exit 0
