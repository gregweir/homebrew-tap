class Homehash < Formula
  desc "Lightweight local-only Bitcoin miner monitor for Bitaxe"
  homepage "https://github.com/gregweir/homeHash"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gregweir/homeHash/releases/download/v0.4.0/homeHash_0.4.0_darwin_arm64.tar.gz"
      sha256 "3e3b1f32e80d8d39b2b179c218275e737013fb6ae2ed251d56e820b01db3cb6c"
    end
    on_intel do
      url "https://github.com/gregweir/homeHash/releases/download/v0.4.0/homeHash_0.4.0_darwin_amd64.tar.gz"
      sha256 "01371287274f1fa7b7115497f2240886d91e940afefcc6d809992b48184363a1"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/gregweir/homeHash/releases/download/v0.4.0/homeHash_0.4.0_linux_arm64.tar.gz"
      sha256 "6d59d4113b1a702e17a59614c0483ac4870789074bd83e73106804d3d078c068"
    end
    on_intel do
      url "https://github.com/gregweir/homeHash/releases/download/v0.4.0/homeHash_0.4.0_linux_amd64.tar.gz"
      sha256 "55c5fba19669fbc2e630470e13cb931cef38d972ff33b6057795baca89c9d481"
    end
  end

  def install
    bin.install "homeHash"
  end

  def caveats
    <<~EOS
      Runs an HTTP dashboard on port 8080 (set HOMEHASH_PORT to change) and
      stores its SQLite database in ./homehash.db, so start it from a
      directory with space to write. Miners on your LAN are discovered
      automatically; see the README for all configuration options:
        https://github.com/gregweir/homeHash/blob/main/README.md
    EOS
  end

  test do
    assert_equal "v#{version}", shell_output("#{bin}/homeHash --version").strip
  end

  service do
    run [opt_bin/"homeHash"]
    keep_alive true
    log_path var/"log/homehash.log"
    error_log_path var/"log/homehash.err.log"
  end
end
