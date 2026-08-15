cask "moldavite" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.0"
  sha256 arm:   "d133dd6789236cd4b9473a5b58f767832e9151f2b3a71e9c66b292c56244d6a9",
         intel: "121943e0cefd6bef17be2239b9e339c1aca2cc2a5201a8f36ef060a3d869cdb6"

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
