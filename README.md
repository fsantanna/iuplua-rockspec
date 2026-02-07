# iuplua-rockspec

LuaRocks package for [IupLua](https://iup.sourceforge.net/) examples
from the official Tecgraf/PUC-Rio documentation.

## Prerequisites

IUP must be installed on your system:
- **Linux**: Install via your package manager or from
  [sourceforge](https://sourceforge.net/projects/iup/files/)
- **Windows**: Download binaries from
  [sourceforge](https://sourceforge.net/projects/iup/files/)
- **macOS**: Build from source

## Install

```sh
luarocks install iuplua-examples
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
