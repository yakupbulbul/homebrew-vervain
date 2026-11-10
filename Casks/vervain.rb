cask "vervain" do
  version "2.2.0"
  sha256 "395191892e59688b755945768c8b4c2c6e38572c4430a2191b2d08d07480a642"

  url "https://github.com/yakupbulbul/Vervain/releases/download/v#{version}/Vervain-#{version}-homebrew.dmg"
  name "Vervain"
  desc "Free, open-source macOS cleaner that respects your files and privacy"
  homepage "https://vervain.app"

  depends_on macos: :sequoia

  app "Vervain.app"

  zap trash: [
    "~/Library/Application Support/Vervain",
    "~/Library/Caches/app.vervain",
    "~/Library/Caches/com.yakupbulbul.Vervain",
    "~/Library/HTTPStorages/app.vervain",
    "~/Library/HTTPStorages/com.yakupbulbul.Vervain",
    "~/Library/Preferences/app.vervain.plist",
    "~/Library/Preferences/com.yakupbulbul.Vervain.plist",
  ]
end
