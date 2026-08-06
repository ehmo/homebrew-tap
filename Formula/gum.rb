class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  version "1.0.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.0.2/gum_1.0.2_darwin_amd64.tar.gz"
      sha256 "5bcef95787285c16204ebfd8a834080f6b27deff9e61162c006611ca9bfcc06d"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.0.2/gum_1.0.2_darwin_arm64.tar.gz"
      sha256 "8bf8db64ab0c156f985433855a1a6efc4c938a40db9a626d9188c9aacf1cad84"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.0.2/gum_1.0.2_linux_amd64.tar.gz"
      sha256 "0d3699e57ee18c744f506c5973f3b8e8a48607a2563a2b97340a2e2bddfbeebb"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.0.2/gum_1.0.2_linux_arm64.tar.gz"
      sha256 "6ed8858d73956d332fbe06989e06048a07551cde78e2bc39b4173624509705df"
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
