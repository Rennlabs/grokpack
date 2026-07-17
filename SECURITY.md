# Security Policy

## Scope

**grokpack** is an unofficial umbrella installer and docs front door for the
Grok Build companion suite (grokprint, grokdrive, grok-hud). It:

- Resolves sibling (or cloned) component repos and runs each component's own
  `install.sh`
- Symlinks vendored HUD bins into `~/.local/bin`
- Ships a draft Claude Code marketplace manifest

It does **not** run Grok itself, load credentials, or implement a PreToolUse
gate. Component tools carry their own `SECURITY.md` policies.

## What we care about

1. **Delegated installers** — suite install invokes component installers that
   may edit `~/.claude/settings.json` and create symlinks under `~/.local/bin`
   and `~/.claude`. Prefer `--dry-run` first; never clobber unrelated files.
2. **No credentials in the repo** — never commit `.env`, tokens, session dumps,
   or real secrets.
3. **Clone sources** — default GitHub sources are `Rennlabs/*` over HTTPS. Pin
   or review component trees before trusting a first-time clone.
4. **Component risk** — grokdrive dispatches with `--always-approve`; see that
   repo's SECURITY policy before enabling it on sensitive trees.

## Reporting

Open a GitHub issue with the `security` label, or email the maintainers via the
org contact on GitHub. Do **not** attach real secrets; use synthetic fixtures.

## Supported versions

Best-effort on the latest `main` / latest release tag only. There is no paid SLA.

## Threat model (short)

| Asset | Risk | Mitigation |
|-|-|-|
| `~/.local/bin` / `~/.claude` symlinks | Path confusion / clobber | Idempotent links; skip non-grokpack targets |
| Component install.sh | Settings surgery | Component-owned backups; suite dry-run |
| Marketplace manifest | Wrong source repo | HTTPS `Rennlabs/*` only; validate before publish |
| Working tree after drive install | Grok `--always-approve` body | Component SECURITY; sandbox when needed |
