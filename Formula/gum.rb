class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.3.0/gum_1.3.0_darwin_amd64.tar.gz"
      sha256 "481ea5ef308ced59edcac03069e4443a3f5468fe210eafed1d4a0686165f68a6"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.3.0/gum_1.3.0_darwin_arm64.tar.gz"
      sha256 "e5089108be21314515ebb3b9c493f1c74b5447dc2c116e4fad100862a6e610cc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.3.0/gum_1.3.0_linux_amd64.tar.gz"
      sha256 "32093ea50ebd3092dde4926d293d8326322e02f46d7ae59e3b6e6c0158f2b87e"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.3.0/gum_1.3.0_linux_arm64.tar.gz"
      sha256 "3d935418cabf8753202b8e718c71b8aa569adf01c0fa4645aab47b2bf4260d4d"
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
