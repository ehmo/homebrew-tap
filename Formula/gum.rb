class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.1.0/gum_1.1.0_darwin_amd64.tar.gz"
      sha256 "58341a27836718d53afef5d54925e533432e689a5cfb77991af0b7f598e78e34"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.1.0/gum_1.1.0_darwin_arm64.tar.gz"
      sha256 "f4fc6ddc8e40da6b0526046039e3d4902144393389918113953a877044cf741f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.1.0/gum_1.1.0_linux_amd64.tar.gz"
      sha256 "0c55a1eabc45390380908ae74e2e6e596dffe8fe3904215b44c4afdab588e43d"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.1.0/gum_1.1.0_linux_arm64.tar.gz"
      sha256 "20d054a6190966025d7d5c66018908e5230e7418d79f7b287861ddf2bcd881be"
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
