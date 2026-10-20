class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.31"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.31/graith_0.73.31_darwin_arm64.tar.gz"
      sha256 "ff26f8e3f00a7b5d5b34a674bfa8904f01723a256719525590cc4368f479835c"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.31/graith_0.73.31_linux_amd64.tar.gz"
      sha256 "92d3c5a3b9fc77f53f8ccdfe6158a3b4221ad34b1f263e7486ca9f33e4ddf94d"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.31/graith_0.73.31_linux_arm64.tar.gz"
      sha256 "ab901b067d0922e25b01d8579cd7f7cb716c0429cb11cdff331020b289b254a1"
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
