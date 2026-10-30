cask "vervain" do
  version "2.1.0"
  sha256 "147039e78f04464e775f24fa790a597b2e1fe590b862112e2a8789a6340680fa"

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
