cask "moldavite" do
  arch arm: "aarch64", intel: "x64"

  version "2.2.2"
  sha256 arm:   "ca4aee67fe0c980a66b2ad020874fd6f4e6d98eb94ce290569f536e741ebbbe0",
         intel: "e5582c5774680f3c63878244227a06cd235ee35c28205053a475ee9125910b48"

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
