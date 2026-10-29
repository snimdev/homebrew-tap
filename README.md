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

## Alpha releases

The cask tracks the alpha channel, so `version` carries a prerelease suffix and
`brew upgrade` follows it. Bump it after a release with the checksum GitHub already
publishes:

```sh
gh release download v1.0.0-alpha.3 --repo snimdev/snim --pattern sha256sums.txt --output -
```

Then edit `version` and `sha256` in `Casks/snim.rb`.

Until github.com/snimdev/snim is public, the DMG is not downloadable without
credentials, so `brew install` fails for anyone but the maintainers. That is also why
this tap is private: it goes public with the app repo.

## Uninstalling

`brew uninstall --zap --cask snim` removes the app and its preferences. Upload
credentials live in the login keychain, which Homebrew cannot touch:

```sh
security delete-generic-password -s dev.snim.s3
security delete-generic-password -s dev.snim.sftp
security delete-generic-password -s dev.snim.ftp
```
