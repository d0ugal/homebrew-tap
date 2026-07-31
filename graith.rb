class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.0/graith_0.73.0_darwin_arm64.tar.gz"
      sha256 "7fd2b4a1edfac270d01b67b074dd8e033d12ac6e6562400932de7ecd49991253"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.0/graith_0.73.0_linux_amd64.tar.gz"
      sha256 "ff982b4bd131e390f4ac1f97ca5717873b08136cdf829ae8bfc2a8cf4e61548d"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.0/graith_0.73.0_linux_arm64.tar.gz"
      sha256 "610d332a38a1b77e90aa88cf8fa9a4f938c7a929be190cac82fcd6c20dc069cb"
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
