class Grpc < Formula
  desc "gRPC is the next generation open source RPC library and framework"
  homepage "http://www.grpc.io/"
  url "https://github.com/grpc/grpc/archive/release-0_11_0.tar.gz"
  sha256 "2d54b207733c5a48d6ce8f62d3a50541d73cd13b3af7df35396ee137d21a12d7"
  head "https://github.com/grpc/grpc.git"

  bottle do
    root_url "http://storage.googleapis.com/grpc-public/bottles"
    # sha256 "9e23cbcc4d4e9850cb608b66c44e76925f54c6d1f377dbeb64dd661c32eb67e4" => :yosemite
    # sha256 "a7cd10d66343f304600343733d47400a857356b03a22dc1dfbff91b5101463b0" => :x86_64_linux
  end

  depends_on "openssl"
  depends_on "pkg-config" => :build
  depends_on "google-protobuf"

  def install
    system "make", "install", "install_grpc_csharp_ext", "prefix=#{prefix}"
    # Link the Objective-C plugin to the name protoc expects.
    # TODO: Do this renaming on make install, for all languages.
    bin.install_symlink bin/"grpc_objective_c_plugin" => "protoc-gen-objcgrpc"
  end

  test do
    system "make", "verify-install"
  end
end
