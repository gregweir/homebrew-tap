class Homehash < Formula
  desc "Lightweight local-only Bitcoin miner monitor for Bitaxe"
  homepage "https://github.com/gregweir/homeHash"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gregweir/homeHash/releases/download/v0.2.0/homeHash_0.2.0_darwin_arm64.tar.gz"
      sha256 "f54fb73c18acc55b22c5a0299bccb63ee1627cd81e6419fa60d7a9c937557236"
    end
    on_intel do
      url "https://github.com/gregweir/homeHash/releases/download/v0.2.0/homeHash_0.2.0_darwin_amd64.tar.gz"
      sha256 "cce05a40b51c5de160f2fabd7d04d9569662e8ae8ece67a973852e029e88a027"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/gregweir/homeHash/releases/download/v0.2.0/homeHash_0.2.0_linux_arm64.tar.gz"
      sha256 "a16b0ee1721ffb40593476485defaf0d470c50b14a39b8564a10b55cb0a04d28"
    end
    on_intel do
      url "https://github.com/gregweir/homeHash/releases/download/v0.2.0/homeHash_0.2.0_linux_amd64.tar.gz"
      sha256 "870638de65785a390ce5b3ad5907bb13b76d0cea480d2ecd933d9f070003a73d"
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
