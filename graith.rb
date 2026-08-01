class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.3/graith_0.73.3_darwin_arm64.tar.gz"
      sha256 "4ac8fe24a56ebd19a4a1371c56ed668652bbbc938466bc4ccbd3cf199f871c40"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.3/graith_0.73.3_linux_amd64.tar.gz"
      sha256 "bc7cff10fa637a45003c87ecb8506b534800562d0bec454fb7a3e454ed1252cc"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.3/graith_0.73.3_linux_arm64.tar.gz"
      sha256 "6a8cd11ed473a91b8677c8ca601df4fbd11ae6ef073ac168dda2116618281994"
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
