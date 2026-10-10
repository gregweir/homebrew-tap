class Homehash < Formula
  desc "Lightweight local-only Bitcoin miner monitor for Bitaxe"
  homepage "https://github.com/gregweir/homeHash"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gregweir/homeHash/releases/download/v0.3.0/homeHash_0.3.0_darwin_arm64.tar.gz"
      sha256 "50e2390eaae998535987857286f35e45bd3cfe518650a449ec439d7241253048"
    end
    on_intel do
      url "https://github.com/gregweir/homeHash/releases/download/v0.3.0/homeHash_0.3.0_darwin_amd64.tar.gz"
      sha256 "fac7f05e2eac0303d4184aa890eeb23fdf35140dd173a093d9b2933d6710101b"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/gregweir/homeHash/releases/download/v0.3.0/homeHash_0.3.0_linux_arm64.tar.gz"
      sha256 "e8b0016aa0edd058ae852f74169c1a3b9c5401a03a9a67d43890b18aa06d3efd"
    end
    on_intel do
      url "https://github.com/gregweir/homeHash/releases/download/v0.3.0/homeHash_0.3.0_linux_amd64.tar.gz"
      sha256 "b4a502a8ee1001a50e1187b55a684e19260a369b598d3005210257220534f40b"
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
