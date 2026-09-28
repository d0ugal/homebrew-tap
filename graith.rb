class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.24"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.24/graith_0.73.24_darwin_arm64.tar.gz"
      sha256 "2478527f204c36677c36b39b38d16343925878f55434a514e5f0613f34584cfc"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.24/graith_0.73.24_linux_amd64.tar.gz"
      sha256 "8278603643b187109bb3a51cd98cf08c62722b6aece3fb6390babac5e05dfe40"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.24/graith_0.73.24_linux_arm64.tar.gz"
      sha256 "6920bf3f2cf573261f43c3c8b7d3890a57aaedfd6cd04918daf14be7a10c76f3"
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
