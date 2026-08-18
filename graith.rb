class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.14"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.14/graith_0.73.14_darwin_arm64.tar.gz"
      sha256 "7bb537a883d3e72fdfbaa264dafa70b8723a23799ef665c3a951f201e3e03679"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.14/graith_0.73.14_linux_amd64.tar.gz"
      sha256 "2e4c8548ac2f94416e00756b9a8e1ad45bee95130d9af1314fd413ab05b673cd"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.14/graith_0.73.14_linux_arm64.tar.gz"
      sha256 "b3699d867c31bae08a4690db72eadcfb7443297c480542f6ee5bc66f00462ae7"
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
