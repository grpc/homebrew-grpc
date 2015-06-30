# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb

class GrpcPhp < Formula
  desc "gRPC PHP extension"
  homepage "http://www.grpc.io/"
  head "https://github.com/grpc/grpc.git", :branch => "release-0_9"
  version "0.9.1"

  depends_on "autoconf"
  depends_on "grpc"

  def install
    cd "src/php/ext/grpc" do
      system "phpize"
      system "./configure", "--prefix=#{prefix}",
                            "--enable-grpc=#{Formula["grpc"].opt_prefix}"
      system "make"
      prefix.install "modules/grpc.so"
    end
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
