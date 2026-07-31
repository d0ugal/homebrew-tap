class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.72.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.72.2/graith_0.72.2_darwin_arm64.tar.gz"
      sha256 "d3c4e5bcac0b51b2d9c21c792c7054c1a9ff2b71f28aa26660de8c0b8570264a"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.72.2/graith_0.72.2_linux_amd64.tar.gz"
      sha256 "48345668a67c01cead985170632732d90c2290d8c4589f7fe2ce716fda83a97e"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.72.2/graith_0.72.2_linux_arm64.tar.gz"
      sha256 "d517813dee8253f6882c43fe6908f6b83f4be1237054e38d6d76ee76bfe0bd0c"
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
