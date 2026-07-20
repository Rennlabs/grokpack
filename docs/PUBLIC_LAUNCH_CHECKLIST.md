# Public Launch Checklist

Use this checklist before any public push, tag, release, marketplace update, or
repo-publication step for **grokpack** and its suite components (grokprint,
grokdrive, grok-hud).

It is intentionally model-neutral so Claude Code, Codex, Grok, and other agents
all follow the same release memory.

Adapted from the Renn Labs model-neutral public-release checklist.

## Required gates (per repo)

Run from each component repo root (and from grokpack for the umbrella):

```bash
# Leak scan (private home paths, personal emails, raw IPv4, common token shapes).
# Report file/line/type only — never print secret values. Patterns live in the
# script as string pieces so docs/fixtures stay scanner-clean.
./scripts/leak-scan.sh          # from grokpack root
# or, in a component repo without the script:
#   git grep -nIE '<maintainer leak regex>' || echo 'leak scan clean'

# Shell / JS syntax
bash -n install.sh
# plus any other shell scripts (bin/*, etc.)
find . -type f \( -name '*.sh' -o -path './bin/*' \) \
  ! -path './.git/*' -print0 | xargs -0 -r bash -n

# Node hooks (when present)
find hooks -name '*.js' -print0 2>/dev/null | xargs -0 -r -n1 node --check

# ShellCheck — severity=error so style warnings don't block
shellcheck --severity=error install.sh
# extend to other scripts as they exist

# JSON validates (when present)
python3 -c "import json,sys; [json.load(open(p)) for p in sys.argv[1:]]" \
  .claude-plugin/plugin.json .claude-plugin/marketplace.json 2>/dev/null || true

# Dry-run install mutates nothing
./install.sh --dry-run
```

Optional when Claude Code plugin tooling is available:

```bash
claude plugin validate .
```

## Scrub rules

- Never print matched secret values. Report only file, line, commit scope, and finding type.
- Keep `.omc/`, `.omx/`, `.grok/`, `.grokprint/`, `.buildlog/`, local state,
  credentials, and private absolute paths out of git.
- If scanner output points at a real credential, rotate or revoke it before doing anything else.
- If the credential is in local history that has not been pushed publicly, scrub/rewrite history
  before pushing. Do not rewrite published history without maintainer approval.
- Test fixtures must not contain complete token-shaped literals. Build fake values from pieces so
  public scanners do not flag the repository.

## Release hygiene

- Bump versions together: `.claude-plugin/plugin.json` + `.claude-plugin/marketplace.json`
  (when present) + `CHANGELOG.md`.
- Move changelog notes out of `Unreleased` into a dated version section.
- Update README install/upgrade instructions for user-visible behavior or configuration changes.
- Verify any current-market model IDs or availability claims against `grok models` and/or official
  provider docs. Do not assert unreleased IDs. Keep **provider** and **model** distinct:
  Codex, Claude, Grok, and Gemini are providers; specific releases (e.g. Grok 4.5) are models.
- Carry the "**Unofficial** — not affiliated with xAI" disclaimer in each public README.
- Prefer best-effort / break-risk language when documenting third-party CLI flags or output shapes.

## Governance present

Before first public exposure, each repo should have:

| Artifact | Purpose |
|-|-|
| `LICENSE` | MIT (or equivalent) |
| `README.md` | Install, scope, unofficial banner |
| `CHANGELOG.md` | Dated versions |
| `CONTRIBUTING.md` | How to hack / PR |
| `SECURITY.md` | Scope + reporting |
| `.github/workflows/ci.yml` | Syntax / shellcheck / JSON gates |
| `.gitignore` | Local state / build / agent dirs |

## Human-gated (require maintainer approval)

Creating or changing remotes, pushing, tagging, publishing packages or marketplace
listings, making the repo public, and adding live-provider CI all require explicit
maintainer approval. Agents prepare commits and proof locally only.
