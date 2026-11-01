# Snim Homebrew tap

The macOS cask for [Snim](https://snim.dev), a screenshot, screen recording, OCR and
upload tool.

```sh
brew tap snimdev/tap
brew install --cask snim
```

Apple silicon only for now: the release workflow builds a single arm64 DMG.

## Signed and notarized

The DMG is signed with a Developer ID and notarized by Apple, so Snim opens without a
Gatekeeper warning. On first capture macOS asks for Screen Recording permission.

## Releases

The cask follows stable releases, and `livecheck` watches the latest GitHub release.
After every stable release, the app's release workflow sets `version` and `sha256` in
`Casks/snim.rb` and commits it as `snim-bot`. To bump it by hand instead, take the
checksum GitHub already publishes:

```sh
gh release download v1.0.1 --repo snimdev/snim --pattern sha256sums.txt --output -
```

Then edit `version` and `sha256` in `Casks/snim.rb`.

## Uninstalling

`brew uninstall --zap --cask snim` removes the app and its preferences. Upload
credentials live in the login keychain, which Homebrew cannot touch:

```sh
security delete-generic-password -s dev.snim.s3
security delete-generic-password -s dev.snim.sftp
security delete-generic-password -s dev.snim.ftp
```
