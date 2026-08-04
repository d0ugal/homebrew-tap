class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.6/graith_0.73.6_darwin_arm64.tar.gz"
      sha256 "a57bdbe08d31712d77b88acaf25611b6a535ab0be77e0046aaf89aa93c6b64ba"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.6/graith_0.73.6_linux_amd64.tar.gz"
      sha256 "638b887512ca7c8598e7e1e6ec37ad9bc8693c7ea10ba9344e874b4e6daac63e"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.6/graith_0.73.6_linux_arm64.tar.gz"
      sha256 "7e9e8aa951835a6df33ff434fff1131928d7665659d18c89c387a41b8a4f1dd5"
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
