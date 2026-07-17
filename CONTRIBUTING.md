# Contributing

Thanks for interest in **grokpack** (unofficial Grok Build companion suite).

## Dev setup

```bash
git clone https://github.com/Rennlabs/grokpack.git
cd grokpack
bash -n install.sh hud/grok-hud hud/grok-with-hud
python3 -c "import json; json.load(open('.claude-plugin/marketplace.json'))"
./install.sh --dry-run
```

## Guidelines

1. Suite installer stays thin: resolve components, delegate to their installers,
   symlink vendored HUD bins. Do not re-implement component hooks here.
2. Keep multi-engine fuse/route tools (fleet-fuse, peer, …) out of this pack —
   they are cross-model, not Grok-specific.
3. Small PRs; run `bash -n` (and shellcheck when available) before pushing.
4. No secrets in docs or fixtures (synthetic only).

## PR checklist

- [ ] `bash -n install.sh hud/grok-hud hud/grok-with-hud` passes
- [ ] Marketplace JSON still parses
- [ ] No secrets or private absolute paths in the diff
- [ ] README / `docs/routing.md` / launch checklist updated if install or suite
      composition changes
- [ ] CHANGELOG note under Unreleased (or next version)

## Public launch

Before any push/tag/publish, follow [`docs/PUBLIC_LAUNCH_CHECKLIST.md`](docs/PUBLIC_LAUNCH_CHECKLIST.md).

## Code of conduct

Be respectful. This is a small best-effort project.
