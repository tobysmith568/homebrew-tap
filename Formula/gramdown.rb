class Gramdown < Formula
  desc "Turn a Grammarly .docx export into clean, GitHub-Flavored Markdown, from the command line."
  homepage "https://gramdown.tobythe.dev"
  license "ISC"
  version "1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/tobysmith568/gramdown/releases/download/v1.0.0/gramdown-darwin-arm64"
      sha256 "3bca21d193fa14b0b49cee984d60f49ca48c6d729d92c336eb02c10e624c2f4b"
    end
    on_intel do
      url "https://github.com/tobysmith568/gramdown/releases/download/v1.0.0/gramdown-darwin-x64"
      sha256 "089e8632235649378afac2bbb87f87b46c77bbfd8a6e32f2b1bd211469279332"
    end
  end

  def install
    binary = Dir["gramdown-darwin-*"].first
    bin.install binary => "gramdown"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gramdown --version")
  end
end
