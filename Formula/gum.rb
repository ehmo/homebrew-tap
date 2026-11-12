class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.3.3/gum_2.3.3_darwin_amd64.tar.gz"
      sha256 "e1f790ba36554af43cf1dc6998a62ce577cb9b51af7864cc6ca459421cc84528"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.3.3/gum_2.3.3_darwin_arm64.tar.gz"
      sha256 "eff3305d6713be2e69542ba1e5afeba80487aa06a024e23c0b606fedb358e564"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v2.3.3/gum_2.3.3_linux_amd64.tar.gz"
      sha256 "892483ddc3208e71eb94fed1c76052bebbacf6f4965a205cb3e5d6e9804a0bf9"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v2.3.3/gum_2.3.3_linux_arm64.tar.gz"
      sha256 "e1b35dd2c247d2e3eefcb7612ff56d084e0c0fa21ee17083a44934d7c9847cf0"
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
