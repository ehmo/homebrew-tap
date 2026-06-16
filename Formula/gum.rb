class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  version "1.0.0"
  revision 1
  license "FSL-1.1-ALv2"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.0.0/gum_1.0.0_darwin_amd64.tar.gz"
      sha256 "e111047de95f0b99b8c8824a38654293e48086c2a729f96dfc47f2d59865f6eb"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.0.0/gum_1.0.0_darwin_arm64.tar.gz"
      sha256 "5a0df726df0b3253d63df17b339e6a8e9fbbbdd5e6aef0ce1557f4c95077ec63"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.0.0/gum_1.0.0_linux_amd64.tar.gz"
      sha256 "17cc856f7e0d499ec8e0a751beba3325fb1737d9f348488cc022e587e6ba73ac"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.0.0/gum_1.0.0_linux_arm64.tar.gz"
      sha256 "5f5fcfc5676ec7c2e790040b88295bf642417faa6ecbc88c5e24202c280b83c1"
    end
  end

  def install
    libexec.install "gum"
    bin.write_exec_script libexec/"gum"

    return unless OS.mac?

    quiet_system "xattr", "-d", "com.apple.quarantine", libexec/"gum"
    quiet_system "codesign", "--force", "--sign", "-", libexec/"gum"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gum --version")
    assert_match "Run the gum MCP server", shell_output("#{bin}/gum mcp --help")
    system bin/"gum", "help"
  end
end
