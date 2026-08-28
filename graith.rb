class Graith < Formula
  desc "Terminal session manager for AI coding agents"
  homepage "https://github.com/d0ugal/graith"
  version "0.73.19"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.19/graith_0.73.19_darwin_arm64.tar.gz"
      sha256 "33ec3d7ceb36a96a8e22b584708572618b164dfe76a56d9b48840c612dc382d8"
    else
      odie "graith supports only Apple Silicon on macOS"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.19/graith_0.73.19_linux_amd64.tar.gz"
      sha256 "d91cd70e7f0ab898d4264bb7d73f8996c1808d2d57d8385ad428876604958588"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/d0ugal/graith/releases/download/v0.73.19/graith_0.73.19_linux_arm64.tar.gz"
      sha256 "3953953fea93e4e3a21a337ddd20c8b6d7383b5ac6ab033584a4d6d4c5c36d24"
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
