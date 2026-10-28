# Moomer Homebrew tap

[Moomer](https://github.com/Borfak/moomer) is a macOS screen zoomer.
Version 2 is a complete rewrite from Rust to Swift, with Metal rendering and
live ScreenCaptureKit capture.

## Install or upgrade

Requires macOS 14+ and Xcode 16+ to build from source.

```sh
brew install Borfak/moomer/moomer
```

Already have the Rust version?

```sh
brew update
brew upgrade Borfak/moomer/moomer
```

The formula builds and installs the full application bundle, including its
shader resources, and provides a `moomer` command.

```sh
moomer --version
moomer --live --fps auto
```

For a Finder-style launch:

```sh
open "$(brew --prefix moomer)/Moomer.app" --args --live --fps auto
```

Allow Moomer in System Settings → Privacy & Security → Screen Recording
(or Screen & System Audio Recording), then relaunch. Local ad-hoc signatures
can require granting access again after an upgrade.

## Cmd + Shift + Z

With [skhd](https://github.com/koekeishiya/skhd) installed, replace the existing
binding in `~/.config/skhd/skhdrc`. For a standard Apple Silicon installation:

```sh
cmd + shift - z : /usr/bin/open /opt/homebrew/opt/moomer/Moomer.app --args --live --fps auto
```

On an Intel Mac the standard prefix is `/usr/local`, so use
`/usr/local/opt/moomer/Moomer.app`. For a custom installation, get the app path
with `brew --prefix moomer`.

Reload skhd after editing and allow it Accessibility access. Use the Homebrew
app path here: a manually installed `/Applications/Moomer.app` is a separate
copy and is not updated by `brew upgrade`.

Space toggles live/freeze. Tab toggles monitor following. Escape quits.

## Checks

GitHub Actions builds the formula from the published source archive and checks
the CLI version/help, shader resources, and application signature. These checks
do not start the overlay or request Screen Recording permission.
