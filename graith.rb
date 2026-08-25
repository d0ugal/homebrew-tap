class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.16"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.16/graith_0.73.16_darwin_arm64.tar.gz"
      sha256 "1afa058154564bf6ed703f56fa398f496a4da14533b84e34e49032548bf0c5a7"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.16/graith_0.73.16_linux_amd64.tar.gz"
      sha256 "b48a1f602108f9834e62814788af50f060c8cc1c8c00beb770a6c4c27e9ad3cb"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.16/graith_0.73.16_linux_arm64.tar.gz"
      sha256 "d7072c4fa3faf9e72891a1fbaf845ce72afbd670336011deadd1559e233d3a1a"
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
