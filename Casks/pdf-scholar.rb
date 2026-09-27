cask "pdf-scholar" do
  arch arm: "arm64", intel: "x64"

  version "0.52.0"
  sha256 arm:   "f10186ec7a5c8fead1054f0d8a126b452a61d11fb2cf9804a8a81a97e313cac1",
         intel: "fbfa1c438232bbf0588bac917cc91133cac382a7bcf6f0ad2fceaa859c4ffb59"

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
