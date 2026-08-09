<h1 align="center">Homebrew tap for Moldavite</h1>

<p align="center">
  <em>One command, and the notes app is on your Mac.</em>
</p>

<p align="center">
  <a href="https://github.com/mauropereiira/Moldavite">Moldavite</a> ·
  <a href="https://mauropereiira.github.io/Moldavite/">Website</a> ·
  <a href="https://github.com/mauropereiira/moldavite-skills">Agent Skills</a> ·
  <a href="https://mauropereiira.github.io/Moldavite/guide.html">User Guide</a>
</p>

---

[Moldavite](https://github.com/mauropereiira/Moldavite) is a notes app for macOS.
Your notes are plain Markdown files in a folder you own. It also runs an MCP
server, so Claude and other AI tools can read them on your machine.

This repository holds the Homebrew cask.

## Install

```sh
brew install --cask mauropereiira/moldavite/moldavite
```

That downloads the signed and notarized DMG for your architecture, checks it
against a pinned SHA-256, and puts `Moldavite.app` in `/Applications`.

## The `moldavite` command

The cask also links the app binary onto your `PATH`. Moldavite's MCP server is
the same binary run with `--mcp`, so connecting an AI client is one line:

```sh
claude mcp add moldavite -- moldavite --mcp
```

Add `--forge "Work"` to pin a client to one Forge instead of following whichever
Forge is open in the app.

Pair it with [Moldavite Skills](https://github.com/mauropereiira/moldavite-skills),
which teach an agent the Markdown dialect, the Forge layout, and how the note
tools behave.

## Updates

Moldavite updates itself, verifying each download against a minisign key. The
cask is marked `auto_updates true`, so `brew upgrade` stays out of the way and
lets the app's own updater do the work.

One consequence: the version Homebrew records can lag behind what is installed,
until the next time the cask is bumped. That is expected and self-corrects.

If you would rather Homebrew drive updates:

```sh
export HOMEBREW_UPGRADE_GREEDY_CASKS="moldavite"
```

## Uninstall

```sh
brew uninstall --cask moldavite
```

`brew uninstall --zap moldavite` also removes app support files, caches, logs,
and preferences.

**Your notes are never touched.** They live in `~/Documents/Moldavite/` and are
deliberately absent from the zap list. So is the `Moldavite` Keychain entry,
which holds plugin secrets and a Google Calendar refresh token if you connected
one. Remove those by hand if you want them gone.

## How this stays current

Publishing a Moldavite release runs a job in that repository which waits for both
DMGs to finish uploading, re-hashes them, re-audits the cask, and pushes the bump
here. CI re-runs `brew audit` weekly, so a release that disappears shows up as a
red build instead of a broken install.

## License

[MIT](LICENSE), matching Moldavite itself.
