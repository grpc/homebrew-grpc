class Grpc < Formula
  desc "gRPC is the next generation open source RPC library and framework"
  homepage "http://www.grpc.io/"
  url "https://github.com/grpc/grpc/archive/release-0_11_1.tar.gz"
  sha256 "1824e5e97b8f04b41c6cf4fe77ea5708ae173bd7650cf2e8d5c794247a61714e"
  head "https://github.com/grpc/grpc.git"

  bottle do
    root_url "http://storage.googleapis.com/grpc-public/bottles"
    # sha256 "9e23cbcc4d4e9850cb608b66c44e76925f54c6d1f377dbeb64dd661c32eb67e4" => :yosemite
    # sha256 "a7cd10d66343f304600343733d47400a857356b03a22dc1dfbff91b5101463b0" => :x86_64_linux
  end

  depends_on "openssl"
  depends_on "pkg-config" => :build
  depends_on "google-protobuf"

  option "without-libgrpc", "Do not install gRPC C core library, only install gRPC protoc plugins."

  def install
    unless build.without? "libgrpc"
      system "make", "install", "install_grpc_csharp_ext", "prefix=#{prefix}"
    else
      system "make", "install-plugins", "prefix=#{prefix}"
    end

    # Link the Objective-C plugin to the name protoc expects.
    # TODO: Do this renaming on make install, for all languages.
    bin.install_symlink bin/"grpc_objective_c_plugin" => "protoc-gen-objcgrpc"
  end

  test do
    system "make", "verify-install"
  end
end
