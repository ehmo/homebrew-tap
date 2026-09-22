class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.1.0/gum_2.1.0_darwin_amd64.tar.gz"
      sha256 "ed77b3f45dde7bdfbb84addf82d45b83521966b8180ea119197cb66748f1c870"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.1.0/gum_2.1.0_darwin_arm64.tar.gz"
      sha256 "887e3ea381ad3aa1469ca491c60a397ef95d2a22bfcf95a35c95abcbfef4c7df"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.1.0/gum_2.1.0_linux_amd64.tar.gz"
      sha256 "0aa33acd5c12812a599a141dfe420e524f1f0d1edd4b3777e96761825b8028cc"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.1.0/gum_2.1.0_linux_arm64.tar.gz"
      sha256 "fb29f0256ebd01b085724ae8c4dda426abc74cfdf50489804549adf26d5dcada"
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
