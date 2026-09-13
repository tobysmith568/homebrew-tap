# Regenerate Formula/<FORMULA>.rb from the env vars supplied by
# .github/workflows/bump-formula.yml. Not meant to be run outside that
# workflow — see its inputs for what each env var means and where it comes
# from on the calling repo's side.

formula = ENV.fetch("FORMULA")
version = ENV.fetch("VERSION")
repo = ENV.fetch("REPO")
desc = ENV.fetch("DESC")
homepage = ENV.fetch("HOMEPAGE")
license = ENV.fetch("LICENSE")
binary_prefix = ENV.fetch("BINARY_PREFIX")
arm64_sha256 = ENV.fetch("ARM64_SHA256")
x64_sha256 = ENV.fetch("X64_SHA256")

formula_class = formula.split(/[-_]/).map { |part| part.capitalize }.join
release_base_url = "https://github.com/#{repo}/releases/download/v#{version}"
arm64_url = "#{release_base_url}/#{binary_prefix}-darwin-arm64"
x64_url = "#{release_base_url}/#{binary_prefix}-darwin-x64"

content = <<~RUBY
  class #{formula_class} < Formula
    desc #{desc.inspect}
    homepage #{homepage.inspect}
    license #{license.inspect}
    version #{version.inspect}

    on_macos do
      on_arm do
        url #{arm64_url.inspect}
        sha256 #{arm64_sha256.inspect}
      end
      on_intel do
        url #{x64_url.inspect}
        sha256 #{x64_sha256.inspect}
      end
    end

    def install
      binary = Dir["#{binary_prefix}-darwin-*"].first
      bin.install binary => #{formula.inspect}
    end

    test do
      assert_match version.to_s, shell_output("\#{bin}/#{formula} --version")
    end
  end
RUBY

File.write("Formula/#{formula}.rb", content)
puts "Wrote Formula/#{formula}.rb for v#{version}"
