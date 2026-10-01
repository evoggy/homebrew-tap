class Bscli < Formula
  desc "CLI for the Bugslayer debug deck for the Crazyflie"
  homepage "https://github.com/evoggy/bugslayer-cli"
  version "0.1.0"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.0/bscli-aarch64-apple-darwin.tar.gz"
      sha256 "8700979176120fc5a504dd5cba74b2de892d12b32247453486f2e194c35e6fb3"
    else
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.0/bscli-x86_64-apple-darwin.tar.gz"
      sha256 "23659f7a68b28789a98d91a9d09b69e62a5c367e4db2a638c8f4ccf448fd4c38"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.0/bscli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9d8f9835c8dc8faadd40429dc692e7a546142356b5eca12d8402d6f3eaf41aa1"
    else
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.0/bscli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "46257ada9b38f4bd9b63539529897dacdc479d51ed9426ae3d0d2276dc8710f2"
    end
  end

  def install
    bin.install "bscli"
    bash_completion.install "completions/bscli.bash" => "bscli"
    zsh_completion.install "completions/_bscli"
    fish_completion.install "completions/bscli.fish"
  end

  def caveats
    on_linux do
      <<~EOS
        USB access to the deck needs udev rules (the apt package installs them):
          https://github.com/evoggy/bugslayer-cli/blob/main/udev/70-bugslayer-deck.rules
        Copy the file to /etc/udev/rules.d/, then run:
          sudo udevadm control --reload-rules && sudo udevadm trigger
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bscli --version")
  end
end
