# emilmsh/homebrew-tap

Homebrew tap for [PDF Scholar](https://github.com/emilmsh/pdf-scholar) — a PDF
reader and annotator for the documents you work through rather than skim.

## Install

```sh
brew install --cask emilmsh/tap/pdf-scholar
xattr -cr "/Applications/PDF Scholar.app"
```

The `xattr` line is needed because the macOS build is unsigned (a deliberate
zero-cost decision — [why](https://github.com/emilmsh/pdf-scholar/blob/master/docs/PLATFORMS.md))
and Homebrew ≥ 5 no longer offers `--no-quarantine`: without it, Gatekeeper
reports the app as damaged on first launch.

## Update

```sh
brew upgrade --cask pdf-scholar
xattr -cr "/Applications/PDF Scholar.app"
```

Unsigned apps cannot auto-update, so this is the update channel on macOS.
Each upgrade is a fresh download, so the quarantine flag comes back with it —
hence the second line again.

## Maintenance

The cask is bumped automatically: publishing a release in the main repo
triggers its `update-tap.yml` workflow, which reads the new version and dmg
checksums from the release and runs [`scripts/bump.sh`](scripts/bump.sh)
here. Every push is then audited and test-installed on a macOS runner
([`audit.yml`](.github/workflows/audit.yml)).
