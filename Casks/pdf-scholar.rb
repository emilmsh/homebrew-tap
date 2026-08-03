cask "pdf-scholar" do
  arch arm: "arm64", intel: "x64"

  version "0.31.3"
  sha256 arm:   "d1d38a79f84dd69f1b05807ef0cf5440b61c6e401d5934c4c52eee371f8c1368",
         intel: "966c65c7491bad30f22f47a571654095a0b9dae9f7514242f7ce54ce228b4541"

  url "https://github.com/emilmsh/pdf-scholar/releases/download/v#{version}/PDF-Scholar-#{version}-#{arch}.dmg"
  name "PDF Scholar"
  desc "PDF reader and annotator for scholars"
  homepage "https://emilmsh.github.io/pdf-scholar/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "PDF Scholar.app"

  # The macOS build is unsigned (a deliberate zero-cost decision — see
  # docs/PLATFORMS.md in the main repo), which has two consequences the
  # caveats explain: Gatekeeper friction unless installed --no-quarantine,
  # and no auto-update, so brew upgrade IS the update channel.
  caveats <<~EOS
    PDF Scholar's macOS build is unsigned. If it was installed without
    --no-quarantine and macOS reports the app as damaged on first launch,
    clear the quarantine flag:

      xattr -cr "/Applications/PDF Scholar.app"

    Unsigned apps cannot auto-update; new versions arrive with

      brew upgrade --cask pdf-scholar
  EOS

  zap trash: [
    "~/Library/Application Support/PDF Scholar",
    "~/Library/Preferences/no.emil.pdfx.plist",
    "~/Library/Saved Application State/no.emil.pdfx.savedState",
  ]
end
