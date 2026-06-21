class Moomer < Formula
  desc "Freeze-frame screen zoomer for macOS"
  homepage "https://github.com/Borfak/moomer"
  url "https://github.com/Borfak/moomer/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "276c762d742c9eddec06519d39f6da390e307cdbc8f570d330dc31acca2b1f27"
  license "MIT"
  head "https://github.com/Borfak/moomer.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      moomer needs Screen Recording permission on first run:
        System Settings -> Privacy & Security -> Screen Recording

      To launch it with a global hotkey, use skhd:
        brew install koekeishiya/formulae/skhd
        mkdir -p ~/.config/skhd
        echo 'cmd + shift - z : moomer' >> ~/.config/skhd/skhdrc
        skhd --start-service
      Then grant skhd Accessibility permission. Change "cmd + shift - z" to any
      hotkey you like.
    EOS
  end

  test do
    assert_path_exists bin/"moomer"
  end
end
