class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.27"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.27/graith_0.73.27_darwin_arm64.tar.gz"
      sha256 "1650608c653239b165aa7318458af658fa8601806d698686d111bf58ec35983b"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.27/graith_0.73.27_linux_amd64.tar.gz"
      sha256 "96d81e7b6e816ad738215c95759e5ed18cb7b1a1fe97e707d9ce9aabb9008284"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.27/graith_0.73.27_linux_arm64.tar.gz"
      sha256 "e1fc070ea36173c9dd925fdc46da09548ba3012696ef3b736ff410081959cec5"
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
