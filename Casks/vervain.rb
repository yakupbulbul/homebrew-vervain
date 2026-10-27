cask "vervain" do
  version "2.0.0"
  sha256 "14336e136a625d6e69d8cbc38f067abdb35e9317b56300ae78ad4b174fd2fc4d"

  url "https://github.com/yakupbulbul/Vervain/releases/download/v#{version}/Vervain-#{version}-homebrew.dmg"
  name "Vervain"
  desc "Free, open-source macOS cleaner that respects your files and privacy"
  homepage "https://vervain.app"

  depends_on macos: :sequoia

  app "Vervain.app"

  zap trash: [
    "~/Library/Caches/app.vervain",
    "~/Library/Preferences/app.vervain.plist",
  ]
end
