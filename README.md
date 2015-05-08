# gRPC Homebrew

This repo contains:
- gRPC [homebrew][] formulae
- A utility script that simplifies the install of other gRPC packages

These simplify the installation of gRPC on Mac and Linux.

The formulae will be maintained here rather than adding them to homebrew or
linuxbrew repos directly until gRPC and protobuf 3.0 are GA, i.e, gRPC reaches
1.0 and protobuf 3.0 is released.

Prerequisites
-------------

- On Mac OS X, install [homebrew][].
- On Linux, install [linuxbrew][].

Quick Install
-------------

Thee repo contains [install script][] that can be used to install gRPC and
optionally install the gRPC package for Python, Node.Js and/or Ruby once
[homebrew][]/[linuxbrew][] is installed.  The installer is also available as a
short alias https://goo.gl/getgrpc

- To install the gRPC C core (this comes with gRPC protoc plugins for C++, Python and Ruby)
```sh
$ curl -fsSL https://goo.gl/getgrpc | bash -
```
- To install gRPC Python (it installs the gRPC C core if needed)
  - Tip: This installs the grpc [python package] using pip install; you may want to
    activate a [virtualenv][] before running this.

```sh
$ curl -fsSL https://goo.gl/getgrpc | bash -s python
```
- To install gRPC Node.js (it installs the gRPC C core if needed)
  - Tip: Node needs to be available; you can install it quickly using [nvm][]
```sh
$ curl -fsSL https://goo.gl/getgrpc | bash -s nodejs
```
- To install gRPC Ruby (it installs the gRPC C core if needed)
  - Tip: Ruby needs to be available; you can install it quickly using [rvm][]
```sh
$ curl -fsSL https://goo.gl/getgrpc | bash -s ruby
```

Using the formulae directly
---------------------------
Just `brew tap grpc/grpc` and then `brew install <formula>`.

If this formula conflicts with one from Homebrew/homebrew or another tap, you
can `brew install grpc/grpc/<formula>`.

You can also install via URL:

```
brew install https://raw.githubusercontent.com/grpc/homebrew-grpc/master/<formula>.rb
```

Docs
----
`brew help`, `man brew`, or the Homebrew [wiki][].

[wiki]:http://wiki.github.com/Homebrew/homebrew
[homebrew]:http://brew.sh
[linuxbrew]:https://github.com/Homebrew/linuxbrew
[install script]:https://raw.githubusercontent.com/grpc/homebrew-grpc/master/scripts/install
[virtualenv]: https://virtualenv.pypa.io/en/latest/
[nvm]: https://github.com/creationix/nvm
[rvm]: https://rvm.io
[python package]: https://pypi.python.org/pypi/grpcio
