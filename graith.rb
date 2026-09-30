class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.26"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.26/graith_0.73.26_darwin_arm64.tar.gz"
      sha256 "cc8d439cc8d15f671afd6ffd859ab9c709250766f5b3ce6a525b77290903c939"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.26/graith_0.73.26_linux_amd64.tar.gz"
      sha256 "96240d2ecec569860dd6b8e49d97148fccc5f486810085af3dbef69e05e7fa9a"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.26/graith_0.73.26_linux_arm64.tar.gz"
      sha256 "7de4995956f5e43b5985ecfe758df2ebb2cff1177dd0bca4c138edd6ca8f9d8a"
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
