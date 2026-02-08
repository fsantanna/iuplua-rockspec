# iuplua-rockspec

LuaRocks packages for [IUP](https://iup.sourceforge.net/), a
multi-platform GUI toolkit from Tecgraf/PUC-Rio.

## Prerequisites

IUP must be installed on your system:
- **Linux**: Install via your package manager or from
  [sourceforge](https://sourceforge.net/projects/iup/files/)
- **Windows**: Download binaries from
  [sourceforge](https://sourceforge.net/projects/iup/files/)
- **macOS**: Build from source

## Packages

| Rockspec | Description | External deps |
|----------|-------------|---------------|
| `iuplua` | Core IUP binding | libiup |
| `iuplua-cd` | Canvas Draw | libiup, libcd |
| `iuplua-im` | Image library | libiup, libim |
| `iuplua-gl` | OpenGL canvas | libiup, libGL |
| `iuplua-examples` | 132 Lua examples | (none) |
| `iuplua-all` | Complete bundle (all above) | all |

## Install

```sh
luarocks install iuplua-all    # everything
```

Or install individual packages:

```sh
luarocks install iuplua
luarocks install iuplua-examples
```

## Setup

After installing IUP on the system, use the setup helper
to verify the installation and create symlinks so that
`require "iuplua"` works:

```sh
lua setup.lua --check       # verify IUP libraries
sudo lua setup.lua --link   # create symlinks in cpath
```

## What's Included

132 Lua examples organized into:

| Directory            | Description                        | Count |
|----------------------|------------------------------------|-------|
| `examples/tutorial/` | Progressive tutorial (Ch.2-4)     | 23    |
| `examples/7gui/`     | 7GUIs benchmark                   | 7     |
| `examples/basic/`    | Basic Guide to IupLua             | 23    |
| `examples/elements/` | Per-widget standalone examples    | 79    |

See [examples/README.md](examples/README.md) for the full
directory structure.

## Running Examples

```sh
lua examples/elements/button.lua
```

## References

- IUP homepage: https://iup.sourceforge.net/
- IUP tutorial: https://iup.sourceforge.net/en/tutorial/tutorial1.html
- 7GUIs benchmark: https://iup.sourceforge.net/en/7gui/7gui.html
- Basic Guide: https://iup.sourceforge.net/en/basic/index.html

## License

MIT - See [LICENSE](LICENSE)
