class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.5.0/gum_1.5.0_darwin_amd64.tar.gz"
      sha256 "fd8d02301b138ba7686f6e65e6d55adf8249141b4f53acbfa3103053d3184ef3"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.5.0/gum_1.5.0_darwin_arm64.tar.gz"
      sha256 "2155681a0c67d169b84c5fe9a6179ab5f3bc2b782cbca7cd3b0c6e93dc4d75c9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.5.0/gum_1.5.0_linux_amd64.tar.gz"
      sha256 "f38e7d92a80149e696bdfaa8c5f979c0aaf4db9e10fb34b8ed1a102f2a7f3cfc"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.5.0/gum_1.5.0_linux_arm64.tar.gz"
      sha256 "478cb8884c163221d20810d963b04da7fbdb18a68cabf2e5dc4ad6b4028939f5"
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
