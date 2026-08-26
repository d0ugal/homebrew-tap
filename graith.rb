class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.17"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.17/graith_0.73.17_darwin_arm64.tar.gz"
      sha256 "abae1b0ab305b3ba2975c9ddf6e45106d6f946557123b842686667ddb9943f20"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.17/graith_0.73.17_linux_amd64.tar.gz"
      sha256 "d39a6cb3c886a020c3d8ec893fff821c64dabcc992a3e1b8a9447de0fd7c1f1b"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.17/graith_0.73.17_linux_arm64.tar.gz"
      sha256 "43e79085f7bf026df3b3b80fbf9d4d0b6006b8e798a20cca48ebabe1b79b1203"
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
