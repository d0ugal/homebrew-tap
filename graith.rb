class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.5/graith_0.73.5_darwin_arm64.tar.gz"
      sha256 "ab6d9133fca966b78a6e860293bab2c3e99dd8ac70e6de064ecb035d41342cd2"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.5/graith_0.73.5_linux_amd64.tar.gz"
      sha256 "4d8d50f44b8ca623d9e91dbffd6a482784d5da5abf15c1b1c8e0d130077ab678"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.5/graith_0.73.5_linux_arm64.tar.gz"
      sha256 "24931b19030f97bac863291e4652658701f11707941aff04e60f6d869d314ecc"
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
