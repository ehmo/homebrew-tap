# typed: false
# frozen_string_literal: true

class Asc < Formula
  desc "Fast, AI-agent friendly CLI for App Store Connect"
  homepage "https://github.com/rorkai/App-Store-Connect-CLI"
  version "1.7.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rorkai/App-Store-Connect-CLI/releases/download/1.7.0/asc_1.7.0_macOS_arm64"
      sha256 "502185037bb57112ca3fdcc60c7bc1015c1ed04ea1e7b27656cd699a5f81368b"
    else
      url "https://github.com/rorkai/App-Store-Connect-CLI/releases/download/1.7.0/asc_1.7.0_macOS_amd64"
      sha256 "630df77731b1b33f2c21adfe762a049b5d03fa05584350914f7d8c16005c0535"
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "asc_1.7.0_macOS_arm64" => "asc"
    else
      bin.install "asc_1.7.0_macOS_amd64" => "asc"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/asc --version")
  end
end
