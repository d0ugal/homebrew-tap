class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.1/graith_0.73.1_darwin_arm64.tar.gz"
      sha256 "e69ee8188b112d44589d71ba5b50461486f58539b82384d8905c58128ba86feb"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.1/graith_0.73.1_linux_amd64.tar.gz"
      sha256 "9f62e1bb5c549bae4b7dd4c231d3a55e34eb7c5d97be7a4428253acf9b65b484"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.1/graith_0.73.1_linux_arm64.tar.gz"
      sha256 "3c68df4648c2d7c6c6d9b8fe0859f628a0626eff62af381811eb1639fcb0ecaf"
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
