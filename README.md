# emilmsh/homebrew-tap

Homebrew tap for [PDF Scholar](https://github.com/emilmsh/pdf-scholar) — a PDF
reader and annotator for the documents you work through rather than skim.

## Install

```sh
brew install --cask --no-quarantine emilmsh/tap/pdf-scholar
```

`--no-quarantine` is recommended: the macOS build is unsigned (a deliberate
zero-cost decision — [why](https://github.com/emilmsh/pdf-scholar/blob/master/docs/PLATFORMS.md)),
and the flag spares you Gatekeeper's "damaged app" dialog on first launch.
Installed without it? Run `xattr -cr "/Applications/PDF Scholar.app"` once.

## Update

```sh
brew upgrade --cask pdf-scholar
```

Unsigned apps cannot auto-update, so this is the update channel on macOS.

## Maintenance

The cask is bumped automatically: publishing a release in the main repo
triggers its `update-tap.yml` workflow, which reads the new version and dmg
checksums from the release and runs [`scripts/bump.sh`](scripts/bump.sh)
here. Every push is then audited and test-installed on a macOS runner
([`audit.yml`](.github/workflows/audit.yml)).
