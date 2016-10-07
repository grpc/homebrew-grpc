class Grpc < Formula
  desc "gRPC is the next generation open source RPC library and framework"
  homepage "http://www.grpc.io/"
  url "https://github.com/grpc/grpc/archive/v1.0.0.tar.gz"
  sha256 "c9bc77a4b20e67521f339d78b24375f6a1eddd8d203bb32796406a8005ee1c2a"
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

    # Clone nanopb into third_party/nanopb IF THE DIRECTORY IS EMPTY.
    # gRPC v1.0 has nanopb as a submodule of grpc, which requires a clone
    # of nanopb into the directory. gRPC Master removed the submodule and
    # always have nanopb files in place, in which case a clone would give
    # error.
    # TODO(mxyan): find a better solution
    system "[ \"$(ls -A third_party/nanopb)\" ] || git clone --branch=nanopb-0.3.5 https://github.com/nanopb/nanopb.git third_party/nanopb"

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
