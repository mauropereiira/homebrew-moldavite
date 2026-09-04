cask "moldavite" do
  arch arm: "aarch64", intel: "x64"

  version "2.5.0"
  sha256 arm:   "7d11fb062230c237e3f941373559b7cfc1c6af3dc81e42711e4c1994a07a285e",
         intel: "7d63444da0b1a63d9b2394fa99a02f13ec19b2366f968b603ee6aa9e9ead3c64"

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
