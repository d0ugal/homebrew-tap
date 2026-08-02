class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.4/graith_0.73.4_darwin_arm64.tar.gz"
      sha256 "03f60bc0331f7701d142c64bd45aaf73b9e8e3c03edbaf3247c56df1af72e6c3"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.4/graith_0.73.4_linux_amd64.tar.gz"
      sha256 "eb66ba744f057b85d78d16ab87c1a7aadcd2e28708bb4b6a12a35ca90a883f89"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.4/graith_0.73.4_linux_arm64.tar.gz"
      sha256 "820633d3924f3502d37ded7c982485b4e91dcd7be2a1cb8fa7d45418994c435f"
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
