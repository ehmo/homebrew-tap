class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.2.1/gum_2.2.1_darwin_amd64.tar.gz"
      sha256 "96d2fdb01c25f53db4a4b9045b2e0f2064040ec830dde085c290e8f29faff0c1"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.2.1/gum_2.2.1_darwin_arm64.tar.gz"
      sha256 "2c8ad0544f9e6144ac6c32e0b1dc61a431de943d29c0eb0f0fe6e3a62f2e4edf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.2.1/gum_2.2.1_linux_amd64.tar.gz"
      sha256 "c33c42ac5a3cb75363ed55d6b13838ede3eaff8bf4018cb300fa00f3cd817096"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.2.1/gum_2.2.1_linux_arm64.tar.gz"
      sha256 "4f9fa968056bd29f9565d4d93bfde14df36f92763aea9332f3e159cda1b9c82c"
    end
  end

  def install
    # Install the published binary byte for byte. brew fetches over curl, which
    # sets no com.apple.quarantine attribute, and the Go linker already ad-hoc
    # signs the darwin builds. Stripping quarantine or re-signing here would
    # only rewrite the file and break its match with release-binaries.sha256.
    libexec.install "gum"
    bin.write_exec_script libexec/"gum"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gum --version")
    assert_match "Run the gum MCP server", shell_output("#{bin}/gum mcp --help")
    system bin/"gum", "help"
  end
end
