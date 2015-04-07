# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb

class Grpc < Formula
  homepage "http://www.grpc.io/"
  head "https://github.com/grpc/grpc.git"
  url "https://github.com/grpc/grpc/archive/release-0_5_0.tar.gz"
  version "0.5.0"
  sha256 "9c548b4ed2dd3dad7de26633a37cf1342b5f7edb51f66623bbbe3a26306580e3"

  depends_on "protobuf"
  depends_on "openssl"

  devel do
    url "https://github.com/grpc/grpc/archive/release-0_5_0.tar.gz"
    version "0.5.0"
    sha256 "9c548b4ed2dd3dad7de26633a37cf1342b5f7edb51f66623bbbe3a26306580e3"
  end

  def install
    system "make", "install"
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
