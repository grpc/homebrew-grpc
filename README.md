# gRPC Homebrew

A centralized repository for gRPC brews.
These simplify the installation of gRPC.

Prequisites
-----------

- On Mac OS X, install [homebrew][].
- On Linux, install [linuxbrew][].

How do I install these formulae?
--------------------------------
Just `brew tap grpc/grpc` and then `brew install <formula>`.

If the formula conflicts with one from Homebrew/homebrew or another tap, you can `brew install grpc/grpc/<formula>`.

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
