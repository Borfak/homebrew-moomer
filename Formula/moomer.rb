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

  test do
    assert_path_exists bin/"moomer"
  end
end
