cask "snim" do
  version "1.0.0-alpha.2"
  sha256 "43888318068fd5408319e35c18d99c1f3b0c70f54222cf6d49acc5a69987b94e"

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

  # Only an arm64 DMG is built, against the Homebrew Qt of a Sonoma runner.
  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

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
