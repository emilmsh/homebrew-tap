cask "pdf-scholar" do
  arch arm: "arm64", intel: "x64"

  version "0.73.3"
  sha256 arm:   "7fadf195ed8eca40534608327e2f9d09ef490de9fab41f60a847da1f9c26bac6",
         intel: "12c3e0cfe1f170723c8d79e05e74052af347641cf30a9e8a9de62c66635559c7"

  url "https://github.com/emilmsh/pdf-scholar/releases/download/v#{version}/PDF-Scholar-#{version}-#{arch}.dmg"
  name "PDF Scholar"
  desc "PDF reader and annotator for scholars"
  homepage "https://emilmsh.github.io/pdf-scholar/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The bare form: `brew style` (Homebrew/OSDependsOn, since 2026-10) rejects
  # a minimum version Homebrew itself no longer runs below, and wants the
  # macOS-only declaration without one. The versioned stanza failed every
  # bump since 0.67.0 and mailed Emil each time.
  depends_on :macos

  app "PDF Scholar.app"

  zap trash: [
    "~/Library/Application Support/PDF Scholar",
    "~/Library/Preferences/no.emil.pdfx.plist",
    "~/Library/Saved Application State/no.emil.pdfx.savedState",
  ]

  # The macOS build is unsigned (a deliberate zero-cost decision — see
  # docs/PLATFORMS.md in the main repo), which has two consequences the
  # caveats explain: Gatekeeper quarantine (Homebrew >= 5 no longer offers
  # --no-quarantine), and no auto-update, so brew upgrade IS the update
  # channel.
  caveats <<~EOS
    PDF Scholar's macOS build is unsigned, so macOS quarantines it on
    every install and upgrade. If Gatekeeper reports the app as damaged
    when it first opens, clear the flag:

      xattr -cr "/Applications/PDF Scholar.app"

    Unsigned apps cannot auto-update; new versions arrive with

      brew upgrade --cask pdf-scholar
  EOS
end
