class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.72.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.72.0/graith_0.72.0_darwin_arm64.tar.gz"
      sha256 "01792239282f4fe3120b3b0a79b64baf80fb7f320386578b19f46d61d5173199"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.72.0/graith_0.72.0_linux_amd64.tar.gz"
      sha256 "dd9b48aae8e707745e2048315be477035202b974875210da53f1a4ca5a9eb382"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.72.0/graith_0.72.0_linux_arm64.tar.gz"
      sha256 "cd113a006f6c4a2d44f0b55e66f9fa2b3224d057cfe559401f1954cf6a319f02"
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
