class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.21"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.21/graith_0.73.21_darwin_arm64.tar.gz"
      sha256 "cd42342c4f2c0f38a3650c44b0e7d3a3c467b0253653cca752a108b25f0c35fb"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.21/graith_0.73.21_linux_amd64.tar.gz"
      sha256 "bbfa5990e46bcae287219dfb86d4f9a5c7624af5c32ea929cca3b3c549b6a1d8"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.21/graith_0.73.21_linux_arm64.tar.gz"
      sha256 "3b4f67d2201f0a2387a54ce8735d13a34d2bb704b002b554cb4391e7279bc65e"
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
