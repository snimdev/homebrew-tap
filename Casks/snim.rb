cask "snim" do
  version "1.0.0-rc.1"
  sha256 "175399d9796b83de1fac6ecbf48a8cc229b63ecdf1b2ad4c4c48270328910d4c"

  url "https://github.com/snimdev/snim/releases/download/v#{version}/Snim-#{version}-macos-arm64.dmg",
      verified: "github.com/snimdev/snim/"
  name "Snim"
  desc "Screenshot, screen recording, OCR and upload tool"
  homepage "https://snim.dev/"

  # The releases are prereleases, which the default GitHub strategy skips.
  livecheck do
    url :url
    strategy :github_releases do |json|
      json.map do |release|
        next if release["draft"]

        release["tag_name"]&.delete_prefix("v")
      end
    end
  end

  # Only an arm64 DMG is built, and macdeployqt bundles the Homebrew Qt of the macOS 15
  # runner it was built on, so Sequoia is the floor.
  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

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
