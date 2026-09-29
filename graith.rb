class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.25"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.25/graith_0.73.25_darwin_arm64.tar.gz"
      sha256 "47628f395984e5dc621f1a541e0ca3ff134daa39eee6ac59b0df2ebcda03cf91"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.25/graith_0.73.25_linux_amd64.tar.gz"
      sha256 "cfba86e8c45dbe20a9ea2c2d55ccfab46c58ceb5a1c5d140a25d2be6d3a1c8c2"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.25/graith_0.73.25_linux_arm64.tar.gz"
      sha256 "1d5402826a15ef02a7d783415de396743f293bd3f7c4c27dfaf483b03fe7964e"
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
