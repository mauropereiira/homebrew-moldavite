cask "moldavite" do
  arch arm: "aarch64", intel: "x64"

  version "2.3.0"
  sha256 arm:   "c29935aa30b1a3396f271de8c6fadb880976b51a5d852e9cc85e57bda15d5db7",
         intel: "e778412303e06eee1dd7b6283afc738a0f80a0cbdd4874f9d66c8215dea5e26c"

  # The tag carries a "v" prefix; the filenames do not.
  url "https://github.com/mauropereiira/Moldavite/releases/download/v#{version}/Moldavite_#{version}_#{arch}.dmg"
  name "Moldavite"
  desc "Local-first Markdown notes app with a built-in MCP server"
  homepage "https://github.com/mauropereiira/Moldavite"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Moldavite updates itself through its own minisign-verified updater, so
  # Homebrew must not try to reinstall over the top of a newer bundle.
  auto_updates true
  depends_on :macos

  app "Moldavite.app"
  # Puts `moldavite --mcp` on PATH. The --mcp branch returns before Tauri
  # initialises, so the binary runs headless from outside the bundle.
  binary "#{appdir}/Moldavite.app/Contents/MacOS/moldavite"

  uninstall quit: "app.moldavite"

  # Never list ~/Documents/Moldavite here. That is where the user's notes live.
  zap trash: [
    "~/Library/Application Support/Moldavite",
    "~/Library/Caches/app.moldavite",
    "~/Library/Caches/moldavite",
    "~/Library/Logs/app.moldavite",
    "~/Library/Preferences/app.moldavite.plist",
    "~/Library/Preferences/moldavite.plist",
    "~/Library/WebKit/app.moldavite",
    "~/Library/WebKit/moldavite",
  ]
end
