class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.10/graith_0.73.10_darwin_arm64.tar.gz"
      sha256 "ec59af09eaccdf30f94315cfcd3f5d33787995572dfe009952001c6a4a91f5cd"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.10/graith_0.73.10_linux_amd64.tar.gz"
      sha256 "6a2cc675b2268bc056158e253fbd28108dbb69a09c4bc1ee2917a5029a751145"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.10/graith_0.73.10_linux_arm64.tar.gz"
      sha256 "c1721661bb2f615e63a38299787bac765e4544cb624c1bf607250a83f2f96869"
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
