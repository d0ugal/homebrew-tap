class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.13"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.13/graith_0.73.13_darwin_arm64.tar.gz"
      sha256 "1a7c6e54ea5ece2e904d3603a6452d1cd4831293bdcf5714e84e044145425da4"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.13/graith_0.73.13_linux_amd64.tar.gz"
      sha256 "e655aa2f2a5fbd57a7e2f19d052f3fd517349334bf711fba455895791fd93af9"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.13/graith_0.73.13_linux_arm64.tar.gz"
      sha256 "1bd1523c1fb1844b38c22790c5e355864d9c3def708dcbd29128d2683a415a4d"
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
