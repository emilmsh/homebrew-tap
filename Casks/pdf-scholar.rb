cask "pdf-scholar" do
  arch arm: "arm64", intel: "x64"

  version "0.81.0"
  sha256 arm:   "963f308966ec5732ed7be0d0e637b9517d67c9d1b491d2b66624da3cb722bbbd",
         intel: "8c7ee42c9f832812264e21ea477a94b1838e348d392c11148003141b04f9adc1"

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
