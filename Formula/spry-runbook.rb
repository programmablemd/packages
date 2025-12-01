class SpryRunbook < Formula
  desc "Spry Runbook CLI - A runbook execution tool"
  homepage "https://github.com/programmablemd/packages"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/programmablemd/packages/releases/download/v0.1.1/spry-runbook-macos.tar.gz"
      sha256 "09c21b73030e8e343654a3cb4e3733d54b6e0ac01ad17ac18c9eaaf43be262d3"
    else
      url "https://github.com/programmablemd/packages/releases/download/v0.1.1/spry-runbook-macos.tar.gz"
      sha256 "09c21b73030e8e343654a3cb4e3733d54b6e0ac01ad17ac18c9eaaf43be262d3"
    end
  end

  on_linux do
    url "https://github.com/programmablemd/packages/releases/download/v0.1.1/spry-sqlpage_0.1.1-ubuntu22.04u1_amd64.deb"
    sha256 "b8c2b84cc287bfc9e8e29895a740aa0844bf680bf424bc7e87d39a57cdd53160"
  end

  def install
    if OS.mac?
      bin.install "spry-runbook-macos" => "spry-runbook"
    elsif OS.linux?
      # For Linux, extract the DEB package using dpkg-deb
      system "dpkg-deb", "-x", "spry-sqlpage_0.1.1-ubuntu22.04u1_amd64.deb", "."
      bin.install "usr/bin/spry-runbook"
    end
  end

  test do
    system "#{bin}/spry-runbook", "--version"
  end
end

