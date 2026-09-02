class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.20"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.20/graith_0.73.20_darwin_arm64.tar.gz"
      sha256 "4df58ccbb264b16d82041e5c3e2681df2101c45359fc46b051ed7b7896b2edfd"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.20/graith_0.73.20_linux_amd64.tar.gz"
      sha256 "0c0b898015a70d5dddd449b1d1aeb9fcdb26a9cd067e359823925a09b5f2cf17"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.20/graith_0.73.20_linux_arm64.tar.gz"
      sha256 "8527be1ccd4e9365486859720095b79dd0c9b75153085dc2a1060d7d4855a990"
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
