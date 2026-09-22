class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.2.0/gum_2.2.0_darwin_amd64.tar.gz"
      sha256 "683a5f4005a84441795dd7a368367b3f31a2846b6db9a0c9b749aaa2e627439b"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.2.0/gum_2.2.0_darwin_arm64.tar.gz"
      sha256 "e82532be854b609a9968d2f5f1e3d91a0a0fef39945634fd655af86a972c578f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.2.0/gum_2.2.0_linux_amd64.tar.gz"
      sha256 "76b2e176967b68f58d57a3d6177b53ab94dfe0a1b7df5e24313a5e3df6f21251"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.2.0/gum_2.2.0_linux_arm64.tar.gz"
      sha256 "7f5847adf4009878ab140f284f394762e7be93fdfd71b984ba06bf6c9206499c"
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
