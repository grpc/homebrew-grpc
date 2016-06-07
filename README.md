# gRPC Homebrew

This repo contains:
- gRPC [homebrew][] formulae
- A utility script that simplifies installation of other gRPC packages

The formulae will be maintained here rather than adding them to the homebrew or
linuxbrew repos until gRPC and protobuf 3.0 are generally available, i.e, gRPC
reaches 1.0 and protobuf 3.0 is released.

*Starting from version 0.13.0 [homebrew][] or [linuxbrew][] should be only
used to install gRPC C core or gRPC C++ libraries.
For other languages, we already provide standalone packages that contain all
the native dependencies internally and they don't require gRPC C core library
to be installed on your system. If you've installed gRPC C core previously,
you can uninstall it now.*

Prerequisites
-------------

- On Mac OS X, install [homebrew][].
- On Linux, install [linuxbrew][].

Quick Install: Linux or Mac OS X
--------------------------------

The repo contains an [install script][] that can be used to install gRPC C/C++
libraries.
For convenience, the installer is also available at a short alias
https://goo.gl/getgrpc

- To install the gRPC C and C++ libraries
```sh
$ curl -fsSL https://goo.gl/getgrpc | bash -
```

- If you also wish to install gRPC protoc plugins (for all supported languages)
```sh
$ curl -fsSL https://goo.gl/getgrpc | bash -s -- --with-plugins
```

- Alternatively, you can use gRPC formula directly
```sh
brew tap grpc/grpc
brew install --with-plugins grpc
```

Using the formulae directly
---------------------------
Just `brew tap grpc/grpc` and then `brew install <formula>`.

If the formula here conflicts with one from Homebrew/homebrew or another tap, you
can do `brew install grpc/grpc/<formula>`.

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
[protobuf]:https://github.com/google/protobuf/releases
[install script]:https://raw.githubusercontent.com/grpc/homebrew-grpc/master/scripts/install
