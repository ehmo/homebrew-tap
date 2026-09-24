class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.3.1/gum_2.3.1_darwin_amd64.tar.gz"
      sha256 "29eec13cc8b6c299fe6911543629a0fcd89239b9f5a4d6db945c8280e0b98d5d"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.3.1/gum_2.3.1_darwin_arm64.tar.gz"
      sha256 "0c085414052f2fb24b08a3aa86a08f7b3d6c62157666b644b0bb449ccef50629"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.3.1/gum_2.3.1_linux_amd64.tar.gz"
      sha256 "f18795e50452bf4ae76ed9211ffb7a70174bf4284ba7b732a01065fe742895e6"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.3.1/gum_2.3.1_linux_arm64.tar.gz"
      sha256 "ba260135cb6a6dfca993d0521067c08c67a470f60db091cb08dbdb45201cba19"
    end
  end

  def install
    # Install the published binary byte for byte. brew fetches over curl, which
    # sets no com.apple.quarantine attribute, and the Go linker already ad-hoc
    # signs the darwin builds. Stripping quarantine or re-signing here would
    # only rewrite the file and break its match with release-binaries.sha256.
    libexec.install "gum"
    bin.write_exec_script libexec/"gum"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gum --version")
    assert_match "Run the gum MCP server", shell_output("#{bin}/gum mcp --help")
    system bin/"gum", "help"
  end
end
