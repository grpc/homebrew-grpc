class Grpc < Formula
  desc "gRPC is the next generation open source RPC library and framework"
  homepage "http://www.grpc.io/"
  url "https://github.com/grpc/grpc/archive/v1.2.0.tar.gz"
  sha256 "aaadb5888f5371d1f463b7bfa8500817935e1531e8a9f376791fdf3f596332c6"
  head "https://github.com/grpc/grpc.git"

  bottle do
    root_url "http://storage.googleapis.com/grpc-public/bottles"
  end

  depends_on "openssl"
  depends_on "pkg-config" => :build
  depends_on "protobuf"

  option "with-plugins", "Also install gRPC protoc plugins."

  def install

    # Clone nanopb into third_party/nanopb IF THE DIRECTORY IS EMPTY.
    # gRPC v1.0 has nanopb as a submodule of grpc, which requires a clone
    # of nanopb into the directory. gRPC Master removed the submodule and
    # always have nanopb files in place, in which case a clone would give
    # error.
    # TODO(mxyan): find a better solution
    system "[ \"$(ls -A third_party/nanopb)\" ] || git clone --branch=nanopb-0.3.5 https://github.com/nanopb/nanopb.git third_party/nanopb"

    if OS.linux?
      # http://www.linuxquestions.org/questions/programming-9/usr-bin-ld-failed-to-set-dynamic-section-sizes-file-truncated-4175553982/
      system "make", "-j1", "install", "prefix=#{prefix}"
    else
      system "make", "install", "prefix=#{prefix}"
    end

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
