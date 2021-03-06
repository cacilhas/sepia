# SEPIA LATIMANUS

[Kraken](http://www.assembla.com/spaces/kraken-lua/wiki) should be a
great project, but fails at a critical detail: it’s too big!

Kraken aims to solve to many problems, instead of solving the current
one.

A lighter project could be a more elegant approach. So a lighter
cephalopod is [Sepia latimanus](http://en.wikipedia.org/wiki/Broadclub_Cuttlefish).


So Sepia can be that light, it requires some dependencies:

- [Kodumaro Lua](https://github.com/cacilhas/kodumaro-lua)

  Project that provides some useful features to Lua environment, like:

  - base64
  - bignum
  - sss (Simple Stupid Socket)
  - uuid

  Simple Stupid Socket is a lighter approach to
  [Kraken Socket](http://www.assembla.com/spaces/kraken-socket/wiki),
  that suffer the same mistakes of Kraken.

- [lua51pthread](http://lua51pthread.luaforge.net/)

  Project created by [Mildred](mailto:mildred593@online.fr), to provide Posix
  pthread features to Lua.
