# typed: false
# frozen_string_literal: true

class Asc < Formula
  desc "Fast, AI-agent friendly CLI for App Store Connect"
  homepage "https://github.com/rorkai/App-Store-Connect-CLI"
  version "1.8.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rorkai/App-Store-Connect-CLI/releases/download/1.8.0/asc_1.8.0_macOS_arm64"
      sha256 "8192e253148a9764071dcbe081e5c6af30a7e0fd05eb9ff0304a83f166d7fb1f"
    else
      url "https://github.com/rorkai/App-Store-Connect-CLI/releases/download/1.8.0/asc_1.8.0_macOS_amd64"
      sha256 "ef3ad4689fb5fb360afe71db05aa705695916f5126a0b0d4b132b7b48e7957c9"
    end
  end

  on_linux do
    url "https://github.com/rorkai/App-Store-Connect-CLI/archive/refs/tags/1.8.0.tar.gz"
    sha256 "202a2b57b536e10b5d565e08052126fd58265cb213e7592f6ee9949b69e75f3a"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "asc_1.8.0_macOS_arm64" => "asc"
    else
      bin.install "asc_1.8.0_macOS_amd64" => "asc"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/asc --version")
  end
end
