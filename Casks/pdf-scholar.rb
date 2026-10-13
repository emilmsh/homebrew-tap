cask "pdf-scholar" do
  arch arm: "arm64", intel: "x64"

  version "0.61.3"
  sha256 arm:   "34de1cc24ddef689b09ae39ce907b23374dc1175372504809aa0f0944aae78ba",
         intel: "fb1402240e42fb4f62fc7f41c12913998b4a2482bfd7dca23319f061bb7112a4"

  url "https://github.com/emilmsh/pdf-scholar/releases/download/v#{version}/PDF-Scholar-#{version}-#{arch}.dmg"
  name "PDF Scholar"
  desc "PDF reader and annotator for scholars"
  homepage "https://emilmsh.github.io/pdf-scholar/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

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
