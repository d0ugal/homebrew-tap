class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.18"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.18/graith_0.73.18_darwin_arm64.tar.gz"
      sha256 "e6ec77cfa023dea5a4b208a63839bac6fa03cc4d75ead7860a59800d466bc5c4"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.18/graith_0.73.18_linux_amd64.tar.gz"
      sha256 "fc90711d134d104329fe58f755be94db90a84c501ab78baf431669f6ecac66f6"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.18/graith_0.73.18_linux_arm64.tar.gz"
      sha256 "30c6d3f93ec670dbed61c82d7c98406daeb658e52b978baf9fc12453b0f6978d"
    else
      odie "graith supports only Linux amd64/arm64"
    end
  end

  def install
    bin.install "gr"
    if OS.mac?
      (libexec/"graith").install "GraithNotifier.app"
      (libexec/"graith").install "Graith.app"
    end
  end

  def caveats
    <<~EOS
      To restart the graith daemon after upgrading:
        gr daemon restart

      Before uninstalling on macOS, remove every registered Graith user service:
        gr daemon service remove --all-profiles
    EOS
  end

  test do
    system "#{bin}/gr", "version"
  end
end
