class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.2/graith_0.73.2_darwin_arm64.tar.gz"
      sha256 "b803671417c67a067e7e2315e3c26fc9e980be9e24e268c9ae2dcbdf9a3dc834"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.2/graith_0.73.2_linux_amd64.tar.gz"
      sha256 "8e39bd2dc6d3cec18286b4f3ea7c31ae8dcd2f1c2ded2c7882e71a1a704342eb"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.2/graith_0.73.2_linux_arm64.tar.gz"
      sha256 "c48008a1d22872f4105541fda97e7cccdf13be4dfe04c5324e1676a355ba87e9"
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
