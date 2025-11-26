class SprySqlpage < Formula
  desc "Spry SQLPage CLI - A declarative web application framework"
  homepage "https://github.com/programmablemd/packages"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/programmablemd/packages/releases/download/v0.1.0/spry-sqlpage-macos.tar.gz"
      sha256 "f99bd25fa9e28b3390a01d27c824687b7cf7af155339a4e62c08c8e9e7fff407"
    else
      url "https://github.com/programmablemd/packages/releases/download/v0.1.0/spry-sqlpage-macos.tar.gz"
      sha256 "f99bd25fa9e28b3390a01d27c824687b7cf7af155339a4e62c08c8e9e7fff407"
    end
  end

  on_linux do
    url "https://github.com/programmablemd/packages/releases/download/v0.1.0/spry-sqlpage_0.1.0-ubuntu22.04u1_amd64.deb"
    sha256 "95a1f8c423fd6848ebb02bc2603a724fbbb7109420a8acc968fb151167386827"
  end

  def install
    if OS.mac?
      bin.install "spry-sqlpage-macos" => "spry-sqlpage"
    elsif OS.linux?
      # For Linux, extract the DEB package using dpkg-deb
      system "dpkg-deb", "-x", "spry-sqlpage_0.1.0-ubuntu22.04u1_amd64.deb", "."
      bin.install "usr/bin/spry-sqlpage"
    end
  end

  test do
    system "#{bin}/spry-sqlpage", "--version"
  end
end

