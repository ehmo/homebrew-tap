# typed: false
# frozen_string_literal: true

class Xceval < Formula
  desc "Run and inspect Apple Evaluations workflows from the command-line"
  homepage "https://github.com/rudrankriyam/Evaluations-Framework-CLI"
  url "https://github.com/rudrankriyam/Evaluations-Framework-CLI/releases/download/0.1.0/xceval_0.1.0_macOS_universal"
  version "0.1.0"
  sha256 "4b38bd8b346c0b3294cfb5fa2cd66098569da67cda40fd01999719ba9da163e3"
  license "MIT"

  depends_on :macos

  def install
    bin.install "xceval_0.1.0_macOS_universal" => "xceval"
  end

  test do
    assert_match "Apple Evaluations", shell_output("#{bin}/xceval --help")
  end
end
