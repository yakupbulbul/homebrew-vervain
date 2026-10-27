#!/bin/bash
set -euo pipefail

# Points the cask at the latest Vervain release.
# Usage: scripts/bump-cask.sh [path/to/vervain.rb]
#
# Reads the latest published release, downloads the Homebrew copy of its DMG,
# checks the hash and rewrites `version` and `sha256`. Does nothing when the
# cask is already current or the latest release is not newer.

CASK="${1:-Casks/vervain.rb}"
REPO="yakupbulbul/Vervain"

tag="$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p' | head -1)"
[ -n "$tag" ] || { echo "Could not read the latest release"; exit 1; }
latest="${tag#v}"
current="$(sed -n 's/^  version "\(.*\)"$/\1/p' "$CASK")"

if [ "$latest" = "$current" ]; then
    echo "Already on ${current}"
    exit 0
fi
newest="$(printf '%s\n%s\n' "$current" "$latest" | sort -V | tail -1)"
if [ "$newest" != "$latest" ]; then
    echo "Latest release ${latest} is older than the cask (${current}); leaving it alone"
    exit 0
fi

url="https://github.com/${REPO}/releases/download/${tag}/Vervain-${latest}-homebrew.dmg"
dmg="$(mktemp -t vervain-dmg)"
trap 'rm -f "$dmg"' EXIT
curl -fsSL -o "$dmg" "$url" || { echo "No Homebrew DMG at ${url}"; exit 1; }
sha="$(shasum -a 256 "$dmg" | awk '{print $1}')"

sed -i.bak -e "s/^  version \".*\"/  version \"${latest}\"/" -e "s/^  sha256 \".*\"/  sha256 \"${sha}\"/" "$CASK"
rm -f "${CASK}.bak"
echo "Bumped ${current} -> ${latest} (${sha})"
