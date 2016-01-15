# gRPC Homebrew

This repo contains:
- gRPC [homebrew][] formulae
- A utility script that simplifies installation of other gRPC packages

The formulae will be maintained here rather than adding them to the homebrew or
linuxbrew repos until gRPC and protobuf 3.0 are generally available, i.e, gRPC
reaches 1.0 and protobuf 3.0 is released.

Prerequisites
-------------

- On Mac OS X, install [homebrew][].
- On Linux, install [linuxbrew][].

Quick Install: Linux
--------------------

_UPDATE (9/30/2015): Linuxbrew is no longer the official way to install gRPC
on Linux platform. You should use official Debian packages from [jessie-backports][]
to install `libgrpc-dev`. Nevertheless, the Debian packages for the latest version
of [protobuf][] and gRPC protoc plugins (needed to generate code for gRPC service stubs) are still work in progress and the easiest way to install them is using Linuxbrew._

The repo contains an [install script][] that can be used to install gRPC protoc plugins.
For convenience, the installer is also available at a short alias
https://goo.gl/getgrpc

- To install the gRPC protoc plugins for C++, C#, ObjectiveC, Python and Ruby
```sh
$ curl -fsSL https://goo.gl/getgrpc | bash -s plugins
```

- Alternatively, you can use gRPC formula directly
```sh
brew tap grpc/grpc
brew install --without-libgrpc grpc
```

Quick Install: Mac OS X
-----------------------

_UPDATE (9/30/2015): Homebrew continues to be the official way how to install
gRPC on Mac OS X._

The repo contains an [install script][] that can be used to install gRPC and
optionally install the gRPC package for Python, and/or PHP as long as
[homebrew][]/[linuxbrew][] is available.

For convenience, the installer is also available at a short alias
https://goo.gl/getgrpc

- To install the gRPC C core (this also installs the gRPC protoc plugins for C++, C#, ObjectiveC, Python and Ruby)
```sh
$ curl -fsSL https://goo.gl/getgrpc | bash -
```
- To install gRPC Python (it installs the gRPC C core if needed)
  - Prerequisite: python, [pip][] and [virtualenv][]. The installer uses pip to install
    the grpc [python package][].
    - Install pip
    ```sh
    $ sudo easy_install pip
    ```
    - Before running the install script, activate a [virtualenv][]
    ```sh
    $ sudo pip install virtualenv
    $ virtualenv venv
    $ source venv/bin/activate
    ```
    - Run the installer script
    ```sh
    $ curl -fsSL https://goo.gl/getgrpc | bash -s python
    ```

- To install gRPC PHP extension (it installs the gRPC C core if needed)
  - Prerequisite: PHP 5.5 or higher, php5-dev
```sh
$ curl -fsSL https://goo.gl/getgrpc | bash -s php
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
[jessie-backports]:http://backports.debian.org/Instructions/
[protobuf]:https://github.com/google/protobuf/releases
[install script]:https://raw.githubusercontent.com/grpc/homebrew-grpc/master/scripts/install
[virtualenv]: https://virtualenv.pypa.io/en/latest/
[nvm]: https://github.com/creationix/nvm
[rvm]: https://rvm.io
[python package]: https://pypi.python.org/pypi/grpcio
[pip]: https://pip.pypa.io/en/latest/installing.html
