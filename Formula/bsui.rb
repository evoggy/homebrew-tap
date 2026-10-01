class Bsui < Formula
  desc "Logic analyzer and control UI for the Bugslayer deck for the Crazyflie"
  homepage "https://github.com/evoggy/bugslayer-ui"
  version "0.1.0"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/evoggy/bugslayer-ui/releases/download/0.1.0/bsui-aarch64-apple-darwin.tar.gz"
      sha256 "502e4151faaa867c20e3be802fe5f90612ebb320d7945f4452860a52abc3d248"
    else
      url "https://github.com/evoggy/bugslayer-ui/releases/download/0.1.0/bsui-x86_64-apple-darwin.tar.gz"
      sha256 "b1f41d0009aa6f4e3ab4c1945d22a8f74af2900f8282f70677427ba7c78fc775"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/evoggy/bugslayer-ui/releases/download/0.1.0/bsui-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a230da33cd86a4498ada923c63473131399349bfae91a2240c90b953ab32cf7c"
    else
      url "https://github.com/evoggy/bugslayer-ui/releases/download/0.1.0/bsui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "18d4112d924ff769c3ed2276ff0e2b890e893edea46cf0e5157b7cf57f225316"
    end
  end

  def install
    bin.install "bsui"
  end

  def caveats
    on_linux do
      <<~EOS
        USB access to the deck needs udev rules (the bscli apt package installs them):
          https://github.com/evoggy/bugslayer-cli/blob/main/udev/70-bugslayer-deck.rules
        Copy the file to /etc/udev/rules.d/, then run:
          sudo udevadm control --reload-rules && sudo udevadm trigger
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bsui --version")
  end
end
