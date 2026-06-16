class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  version "1.0.0"
  license "FSL-1.1-ALv2"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.0.0/gum_1.0.0_darwin_amd64.tar.gz"
      sha256 "104f160748845525663ba8288094a3e0b6ca76e7362d59fbaa9d2f0f24314cca"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.0.0/gum_1.0.0_darwin_arm64.tar.gz"
      sha256 "7da209f447fc850bcef769e2eee904b0fa443dd8e901ddcfcc3775f764885cbc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.0.0/gum_1.0.0_linux_amd64.tar.gz"
      sha256 "c74d07033c1c4d6897ea55b539c80d7df2f5ca1f1fceebe1ab4ab5a270774695"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.0.0/gum_1.0.0_linux_arm64.tar.gz"
      sha256 "bc1fbcc570a764cde99b42fd400c328e12f829b85e18324d598b20007a8b980b"
    end
  end

  def install
    bin.install "gum"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gum --version")
    assert_match "Run the gum MCP server", shell_output("#{bin}/gum mcp --help")
    system bin/"gum", "help"
  end
end
