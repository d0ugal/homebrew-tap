class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.7/graith_0.73.7_darwin_arm64.tar.gz"
      sha256 "9fbc08dc418e62a24c226605cc4524ae143f0f9296fb9cdb376a1a1460a70965"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.7/graith_0.73.7_linux_amd64.tar.gz"
      sha256 "77153b63e6becd36b5d93dc6ef93e5a2e1644c34b5654ca65d12f5037268d485"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.7/graith_0.73.7_linux_arm64.tar.gz"
      sha256 "d973300e50d5cfc60ae159cd5295e1868a2e7202a0f2ad1122e15c7adf4627ef"
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
