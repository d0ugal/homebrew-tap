class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.15"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.15/graith_0.73.15_darwin_arm64.tar.gz"
      sha256 "c196d8e68e6268319e6b1a4a931e36cfbeb352ecc2b471c6a6b3c6a0231e5d74"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.15/graith_0.73.15_linux_amd64.tar.gz"
      sha256 "4f6c4804e9fb18f8381b630a51ae0731c237be9de360a2d6e216c386365db43a"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.15/graith_0.73.15_linux_arm64.tar.gz"
      sha256 "6dbfb8a35ca01d68ed743d66fa2ad139f6c06384a56af04e5c2accccd82d8cc0"
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
