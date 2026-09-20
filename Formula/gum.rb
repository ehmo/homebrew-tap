class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.0.1/gum_2.0.1_darwin_amd64.tar.gz"
      sha256 "66121faa7285fc1b7b774f3f7d99bcf1e0706afe907d242be6c6e031ed22ae93"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.0.1/gum_2.0.1_darwin_arm64.tar.gz"
      sha256 "4b764d73acc807e94ede6fad0e0c9bb24d9bc2e68b6e7d7c31fd66ba92d4bc86"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.0.1/gum_2.0.1_linux_amd64.tar.gz"
      sha256 "d039ad2c2d11a27ff22606892aba8d2e71d9a39c2eab1e06c2c6a6e35a74792e"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.0.1/gum_2.0.1_linux_arm64.tar.gz"
      sha256 "6fb212fb4685674a2775333c5bc02d3b494944287bf6d569ff37c12ebad07b0b"
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
