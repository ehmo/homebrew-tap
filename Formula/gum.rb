class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.3.0/gum_2.3.0_darwin_amd64.tar.gz"
      sha256 "e7f18495ea86fd81262953de2a4bb686803363a06cdddc60e0c19cf40c436647"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.3.0/gum_2.3.0_darwin_arm64.tar.gz"
      sha256 "fa9a35d41beb31ac8a51bd16f3b343e68e64feb14491cb28275d6cac72c34696"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.3.0/gum_2.3.0_linux_amd64.tar.gz"
      sha256 "a7aff1a11385910a692efcf0cf8d67476633885e27642de06de7c32ab251eeea"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.3.0/gum_2.3.0_linux_arm64.tar.gz"
      sha256 "86bdf68ee6d16d541184d226bbde488f58535858b0df55bf67fbf69ffc4a91e9"
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
