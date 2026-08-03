#!/usr/bin/env bash
# Bump the pdf-scholar cask to a new release: bump.sh <version> <arm-sha256> <intel-sha256>
# Called by update-tap.yml in emilmsh/pdf-scholar when a release is published.
# GNU sed (CI runs it on ubuntu); the three anchors below are the only lines touched.
set -euo pipefail

VERSION="$1"
ARM_SHA="$2"
INTEL_SHA="$3"
CASK="$(dirname "$0")/../Casks/pdf-scholar.rb"

sed -i -E "s/^(  version \").*(\")$/\1$VERSION\2/" "$CASK"
sed -i -E "s/(arm:   \")[0-9a-f]{64}(\")/\1$ARM_SHA\2/" "$CASK"
sed -i -E "s/(intel: \")[0-9a-f]{64}(\")/\1$INTEL_SHA\2/" "$CASK"

# A silent non-match would push a stale cask that still installs the OLD
# version — fail loudly instead so the workflow run goes red.
grep -q "version \"$VERSION\"" "$CASK" || { echo "version anchor did not match" >&2; exit 1; }
grep -q "$ARM_SHA" "$CASK" || { echo "arm sha anchor did not match" >&2; exit 1; }
grep -q "$INTEL_SHA" "$CASK" || { echo "intel sha anchor did not match" >&2; exit 1; }
