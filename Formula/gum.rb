class Gum < Formula
  desc "Google Universal MCP CLI and stdio server"
  homepage "https://github.com/ehmo/gum"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.2.0/gum_1.2.0_darwin_amd64.tar.gz"
      sha256 "53532d4527a25897f4071df305102877d51d48e6f6d9bc30a105478a8dfd8128"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.2.0/gum_1.2.0_darwin_arm64.tar.gz"
      sha256 "2d15a7ed6ad8263cd6dd80f61afd57040c56c177c5838fe15a9c055684c5cfb8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ehmo/gum/releases/download/v1.2.0/gum_1.2.0_linux_amd64.tar.gz"
      sha256 "f11cb1e7df38069921eb11dda7d82bb57474bbd672289aefb2250aa4a60ffb29"
    end
    on_arm do
      url "https://github.com/ehmo/gum/releases/download/v1.2.0/gum_1.2.0_linux_arm64.tar.gz"
      sha256 "8fcd1425088ad86765bda1bb43829bab2406658155701c766c94905173b3c16e"
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
