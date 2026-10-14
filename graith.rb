class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.29"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.29/graith_0.73.29_darwin_arm64.tar.gz"
      sha256 "ad4bba2ece850da699affab5ce5e31c5e4d75b8a3fdcf37d64e47793199e2ec5"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.29/graith_0.73.29_linux_amd64.tar.gz"
      sha256 "5bffdb53fc9d1a3ae885691d6cb6cd376a36334d9a958408c235846e8a52e040"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.29/graith_0.73.29_linux_arm64.tar.gz"
      sha256 "81465a7384a240f08f7d2ab6055115d14ba3f267a33d8126f855fcde6373ebcb"
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
