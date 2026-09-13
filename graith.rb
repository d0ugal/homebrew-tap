class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.22"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.22/graith_0.73.22_darwin_arm64.tar.gz"
      sha256 "4027bed6c0e4f63774016a8ae78ddefffe46f37b3eb39555e4698893e28da99e"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.22/graith_0.73.22_linux_amd64.tar.gz"
      sha256 "e5b4406b8d30e432df36581e5bd26c9d12928e138d57b94cbdc322c4d46403a1"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.22/graith_0.73.22_linux_arm64.tar.gz"
      sha256 "c8be8ff007dece137e5ace665fbfa59d52d86fed13de907b690e59eb5862bb42"
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
