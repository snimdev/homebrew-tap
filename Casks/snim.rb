cask "snim" do
  version "1.0.1"
  sha256 "67ced41aa19e933ff50469c10391afd84711b3f5e702fcb2062c7e9be9a979f4"

  url "https://github.com/snimdev/snim/releases/download/v#{version}/Snim-#{version}-macos-arm64.dmg"
  name "Snim"
  desc "Screenshot, screen recording, OCR and upload tool"
  homepage "https://snim.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Only an arm64 DMG is built, and macdeployqt bundles the Homebrew Qt of the macOS 15
  # runner it was built on, so Sequoia is the floor.
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Snim.app"

  # Upload credentials live in the login keychain and stay there: Homebrew cannot
  # remove keychain items, so `security delete-generic-password -s dev.snim.s3` (also
  # dev.snim.sftp, dev.snim.ftp) is a manual step.
  zap trash: [
    "~/Library/Preferences/darkog.Snim.plist",
    "~/Library/Preferences/com.darkog.Snim.plist",
    "~/Library/Saved Application State/dev.snim.Snim.savedState",
  ]
end
