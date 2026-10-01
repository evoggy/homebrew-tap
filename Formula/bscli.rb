class Bscli < Formula
  desc "CLI for the Bugslayer debug deck for the Crazyflie"
  homepage "https://github.com/evoggy/bugslayer-cli"
  version "0.1.2"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.2/bscli-aarch64-apple-darwin.tar.gz"
      sha256 "6b543af81439e216e25e8b427cf6fea62e9773bbd440a018e865fe73dcc31d22"
    else
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.2/bscli-x86_64-apple-darwin.tar.gz"
      sha256 "98ed107d4ba750ca1fd6758811efb709dbbf520e0e8e348f1cd4389340c8381e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.2/bscli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a0d89737f229df76077a7606a2896d5012a207f3d0e86b97baf93c0bae829173"
    else
      url "https://github.com/evoggy/bugslayer-cli/releases/download/0.1.2/bscli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f4ac7d65775ac430a0c334df3bae0dc9014a97e38ce67f007fc2fd46c40ef043"
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
