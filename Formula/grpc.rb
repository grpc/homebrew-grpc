# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb

class Grpc < Formula
  homepage "http://www.grpc.io/"
  head "https://github.com/grpc/grpc.git"
  url "https://github.com/grpc/grpc/archive/release-0_9_1.tar.gz"
  version "0.9.1"
  sha256 "baf4259606085501495051127504d8c496526fccaac64eff27565f4cd6234f31"

  depends_on "openssl"
  depends_on "pkg-config" => :build

  bottle do
    root_url "http://storage.googleapis.com/grpc-public/bottles"
    # sha256 "9e23cbcc4d4e9850cb608b66c44e76925f54c6d1f377dbeb64dd661c32eb67e4" => :yosemite
    # sha256 "a7cd10d66343f304600343733d47400a857356b03a22dc1dfbff91b5101463b0" => :x86_64_linux
  end

  def install
    system "make", "install", "install_grpc_csharp_ext", "prefix=#{prefix}"
    # Link the Objective-C plugin to the name protoc expects.
    # TODO: Do this renaming on make install, for all languages.
    bin.install_symlink bin/"grpc_objective_c_plugin" => "protoc-gen-objcgrpc"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test grpc`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
