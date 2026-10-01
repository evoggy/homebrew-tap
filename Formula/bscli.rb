class Bscli < Formula
  desc "CLI for the Bugslayer debug deck for the Crazyflie"
  homepage "https://github.com/evoggy/bugslayer-cli"
  version "0.1.1"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.1/bscli-aarch64-apple-darwin.tar.gz"
      sha256 "0129ce2e12ce27a03dab2bc181b55045267c8d9eec139b9cb9957cd421fc802a"
    else
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.1/bscli-x86_64-apple-darwin.tar.gz"
      sha256 "c9233339081bf914cb58cd6b87d55ebab5129a20449c928b67ed0327ff60941f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.1/bscli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "26b101d06ad1a3449923a459874cc91fe9e5e5dc1d2b0ce3731adf7e977c1dfa"
    else
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.1/bscli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "09a10df3753efe8fb39696542ec0a84e4466573bdb585411545fd48ecd309f9e"
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
