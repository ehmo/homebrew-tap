# typed: false
# frozen_string_literal: true

class Asc < Formula
  desc "Fast, AI-agent friendly CLI for App Store Connect"
  homepage "https://github.com/rorkai/App-Store-Connect-CLI"
  version "1.9.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rorkai/App-Store-Connect-CLI/releases/download/1.9.0/asc_1.9.0_macOS_arm64"
      sha256 "998c39c232176a26fb72a314f1f3fab4571085f4f1c24aef3e3b62626f9179fe"
    else
      url "https://github.com/rorkai/App-Store-Connect-CLI/releases/download/1.9.0/asc_1.9.0_macOS_amd64"
      sha256 "cba85e7d24f2e6ba2a28aa92b53dae1094f99882fab17f2e0722f924c49e812f"
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "asc_1.9.0_macOS_arm64" => "asc"
    else
      bin.install "asc_1.9.0_macOS_amd64" => "asc"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/asc --version")
  end
end
