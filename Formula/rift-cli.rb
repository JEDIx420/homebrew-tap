class RiftCli < Formula
  desc "Command-line interface for the Rift data reconciliation engine"
  homepage "https://github.com/JEDIx420/rift"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/JEDIx420/rift/releases/download/v0.1.1/rift-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a318013404e92c9e8c7e9559dcba73080f7f95ffcd2465ccaf5efb79d3238954"
    end
    if Hardware::CPU.intel?
      url "https://github.com/JEDIx420/rift/releases/download/v0.1.1/rift-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c779fb26d486c6631a6d0bab6b73a2f61863424d92b182d162544cda08dcb090"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/JEDIx420/rift/releases/download/v0.1.1/rift-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3ff76040968aa6edd10e8fdf651a3374c96b05e1a9469008b5d3813db07f8584"
    end
    if Hardware::CPU.intel?
      url "https://github.com/JEDIx420/rift/releases/download/v0.1.1/rift-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "caff77f107d34c4ed61253149599227bb0f9386c2ccbb3ceee80f6742dd7d07e"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "rift"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rift"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rift"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rift"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
