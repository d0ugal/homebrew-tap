class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.23"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.23/graith_0.73.23_darwin_arm64.tar.gz"
      sha256 "4f6ffcdf91e75d7c69f8c3a030589ae3e5ddf1ebc414b4fade9f70b8b3b73e1a"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.23/graith_0.73.23_linux_amd64.tar.gz"
      sha256 "95128189ccc5fd234f72d7cc0b6620bd9e4578c879aff06439f9f22059c300e3"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.23/graith_0.73.23_linux_arm64.tar.gz"
      sha256 "912fe35f2f9f2b934dfdb25db4fc04a47272a0fdce5724fcf7bed7ad1e55da85"
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
