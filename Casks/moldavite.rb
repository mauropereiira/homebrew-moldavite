cask "moldavite" do
  arch arm: "aarch64", intel: "x64"

  version "2.5.1"
  sha256 arm:   "04c4fb7f57879328b62e8c21758e86efc9c239a3127b2f220eea4684338757b9",
         intel: "c624fdbe51f7da117b4caa3b1dab0fcf9b67f3559eef647da09fb4bd74ea2393"

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
