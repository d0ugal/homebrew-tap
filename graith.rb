class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.11/graith_0.73.11_darwin_arm64.tar.gz"
      sha256 "3a1079d06ecc7cda85e097b11a52712b22877ef931b8a795b9b9be340ec14c1c"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.11/graith_0.73.11_linux_amd64.tar.gz"
      sha256 "1057775c3e72229e5611891e840f4d49fc53284ac0fde7a6e2082eb1944fbab9"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.11/graith_0.73.11_linux_arm64.tar.gz"
      sha256 "94e9722c888019247ddbafd75c0dca74542acdd9fa15274a070f9447cdb4c38f"
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
