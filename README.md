# iuplua-rockspec

LuaRocks packages for [IUP](https://iup.sourceforge.net/), a
multi-platform GUI toolkit from Tecgraf/PUC-Rio.

## Install (user)

```sh
sudo luarocks install iuplua
```

That's it. This installs the IUP core C libraries and the
Lua 5.4 bindings. Then:

```sh
lua -e 'require "iuplua"; print("OK")'
```

## Packages

| Rockspec | Description |
|----------|-------------|
| `iuplua` | Core + all bindings (CD, IM, GL, etc.) |
| `iuplua-examples` | 132 Lua examples |

## Examples

```sh
luarocks install iuplua-examples
lua examples/elements/button.lua
```

132 examples organized into:

| Directory            | Description                     | Count |
|----------------------|---------------------------------|-------|
| `examples/tutorial/` | Progressive tutorial (Ch.2-4)  | 23    |
| `examples/7gui/`     | 7GUIs benchmark                | 7     |
| `examples/basic/`    | Basic Guide to IupLua          | 23    |
| `examples/elements/` | Per-widget standalone examples | 79    |

See [examples/README.md](examples/README.md) for details.

## For maintainers

### Repackaging a new IUP release

The rockspec downloads a combined tarball (core + Lua
bindings) from GitHub releases. To create it:

```sh
bash repack.sh 54 Linux515_64
```

This downloads both Tecgraf tarballs from SourceForge,
combines them, and produces
`iuplua-3.32-Lua54_Linux515_64.tar.gz`.

Then upload as a GitHub release:

```sh
gh release create v3.32 iuplua-3.32-Lua54_Linux515_64.tar.gz
```

### Manual alternative (without LuaRocks)

```sh
lua setup.lua --check
sudo lua setup.lua --link
```

## References

- IUP homepage: https://iup.sourceforge.net/
- IUP tutorial: https://iup.sourceforge.net/en/tutorial/tutorial1.html
- 7GUIs benchmark: https://iup.sourceforge.net/en/7gui/7gui.html
- Basic Guide: https://iup.sourceforge.net/en/basic/index.html

## License

MIT - See [LICENSE](LICENSE)
