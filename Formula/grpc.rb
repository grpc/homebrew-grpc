class Grpc < Formula
  desc "gRPC is the next generation open source RPC library and framework"
  homepage "http://www.grpc.io/"
  url "https://github.com/grpc/grpc/archive/release-0_15_0.tar.gz"
  sha256 "d02235dff278869e94cb0dcb31cfea935693c6f87bd73f43d44147185e6becdd"
  head "https://github.com/grpc/grpc.git"

  bottle do
    root_url "http://storage.googleapis.com/grpc-public/bottles"
    # sha256 "9e23cbcc4d4e9850cb608b66c44e76925f54c6d1f377dbeb64dd661c32eb67e4" => :yosemite
    # sha256 "a7cd10d66343f304600343733d47400a857356b03a22dc1dfbff91b5101463b0" => :x86_64_linux
  end

  depends_on "openssl"
  depends_on "pkg-config" => :build
  depends_on "google-protobuf"

  option "with-plugins", "Also install gRPC protoc plugins."

  def install

    # UGLY HACK: we depend on headers from third_party/nanopb being available
    # so we just fetch them from github ourselves.
    # TODO(jtattermusch): find a better solution
    system "git", "clone", "--branch=nanopb-0.3.5", "https://github.com/nanopb/nanopb.git", "third_party/nanopb"

    system "make", "install", "prefix=#{prefix}"

    if build.with? "plugins"
      system "make", "install-plugins", "prefix=#{prefix}"

      # Link the Objective-C plugin to the name protoc expects.
      # TODO: Do this renaming on make install, for all languages.
      bin.install_symlink bin/"grpc_objective_c_plugin" => "protoc-gen-objcgrpc"
    end
  end

  test do
    system "make", "verify-install"
  end
end
