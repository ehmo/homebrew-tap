class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.4.0/gum_1.4.0_darwin_amd64.tar.gz"
      sha256 "cebe67db5e41197ec4de87db886bc1057992341f8f16a51d6d05556efc7fc7ef"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.4.0/gum_1.4.0_darwin_arm64.tar.gz"
      sha256 "1bd6f4b3bb85a2a2bb5f87643a30c4f089ed43e71b55027b873c056acbbb62af"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.4.0/gum_1.4.0_linux_amd64.tar.gz"
      sha256 "58a5fd30ab0797e4e8d3381a82b99f2ecad9a704ed33e2fe5ba376e519104366"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.4.0/gum_1.4.0_linux_arm64.tar.gz"
      sha256 "3c8b2bd1ae396445903f6adfea7532e79422122220100402fe8bb33f02c6c010"
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
