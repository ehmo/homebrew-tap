class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.0.0/gum_2.0.0_darwin_amd64.tar.gz"
      sha256 "9ce7645c309fca30bf5cef5943cc1c1af67d3146208799be24a220258ed8c77a"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.0.0/gum_2.0.0_darwin_arm64.tar.gz"
      sha256 "0b0f74a0f42d1359dec5fe36b985ccc09d947db66022f1e151e5ae2256d53d05"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.0.0/gum_2.0.0_linux_amd64.tar.gz"
      sha256 "eea2a50dad076072f922c6d917a9762f1a2908a875cc8711704140fb4680c2fc"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.0.0/gum_2.0.0_linux_arm64.tar.gz"
      sha256 "5f7992cdf5228d51d2b53ae8720daa09bc3a2c67d209411d63674f30a35ccab1"
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
