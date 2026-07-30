class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.71.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.71.8/graith_0.71.8_darwin_arm64.tar.gz"
      sha256 "d2f8bffd3145b6557b5d221b515b57a131efe546ddb7163dde8c8ed1085061be"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.71.8/graith_0.71.8_linux_amd64.tar.gz"
      sha256 "2cf6c65c3df3d002da8d666460c159f4f259d6876a419fff349e3bf2b8de1c59"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.71.8/graith_0.71.8_linux_arm64.tar.gz"
      sha256 "bd695adb47d35bf6e1a38926fdfedf61f84118d6c5f8248b4900b6f025708f2d"
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
