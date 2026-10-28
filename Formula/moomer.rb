class Moomer < Formula
  desc "Native macOS screen zoomer with live capture"
  homepage "https://github.com/Borfak/moomer"
  url "https://github.com/Borfak/moomer/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "227f056070a56c262f3593985e465294fdde9a195a092903d5207be5375c777e"
  license "MIT"
  head "https://github.com/Borfak/moomer.git", branch: "main"

  depends_on xcode: ["16.0", :build]
  depends_on macos: :sonoma

  def install
    system "./scripts/build-app.sh", "--disable-sandbox", "--jobs", ENV.make_jobs.to_s
    prefix.install "dist/Moomer.app"
    bin.write_exec_script opt_prefix/"Moomer.app/Contents/MacOS/moomer"
  end

  def caveats
    <<~EOS
      Moomer needs Screen Recording permission on first run:
        System Settings -> Privacy & Security -> Screen & System Audio Recording
      Relaunch after granting access. Local ad-hoc builds may need access
      granted again after an upgrade.

      Start live capture:
        open "#{opt_prefix}/Moomer.app" --args --live --fps auto

      For Cmd+Shift+Z, add or replace the binding in ~/.config/skhd/skhdrc:
        cmd + shift - z : /usr/bin/open "#{opt_prefix}/Moomer.app" --args --live --fps auto
      Reload skhd after editing and grant it Accessibility permission.
      This launches the Homebrew app; a manual /Applications copy is separate.

      Space toggles live/freeze. Escape stops capture and exits Moomer.
    EOS
  end

  test do
    assert_equal "moomer 2.0.0", shell_output("#{bin}/moomer --version").strip
    assert_match "Usage: moomer", shell_output("#{bin}/moomer --help")
    resources = prefix/"Moomer.app/Contents/Resources/Moomer_Moomer.bundle"
    assert_path_exists resources
    # SwiftPM can produce a flat bundle or a Contents/Resources layout.
    assert_equal 1, resources.glob("**/Shaders/Zoom.metal").length
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", prefix/"Moomer.app"
  end
end
