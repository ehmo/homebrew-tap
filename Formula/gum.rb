class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.0.3/gum_1.0.3_darwin_amd64.tar.gz"
      sha256 "619eefd220b1d5eacd1dab715714179144ad10da5966ccd3b57a9f58b7eddee2"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.0.3/gum_1.0.3_darwin_arm64.tar.gz"
      sha256 "2926696b354f9d7074d8c14b488837725df259c056dceb1df0b94c9358d52423"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.0.3/gum_1.0.3_linux_amd64.tar.gz"
      sha256 "e436c9a4030f40db442733ff8d0999dd377c322ad65191db87f4d3613a9c34a4"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.0.3/gum_1.0.3_linux_arm64.tar.gz"
      sha256 "21f3ec1b3053f54d2457e474af7a3538406d5f4589ab51724a7bc2bf8c42114e"
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
