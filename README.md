# iuplua-rockspec

LuaRocks packages for [IUP](https://iup.sourceforge.net/), a
multi-platform GUI toolkit from Tecgraf/PUC-Rio.

Bundles precompiled IUP 3.32, CD 5.14, and IM 3.15 libraries
with Lua 5.4 bindings for Linux x86_64.

## Quick Install

```sh
sudo luarocks --lua-version 5.4 build iuplua-3.32-1.rockspec
```

Then:

```sh
lua5.4 -e 'require "iuplua"; iup.Message("Hello", "IUP works!")'
```

## Full Install (all packages)

Install sub-packages individually (order matters):

```sh
sudo luarocks --lua-version 5.4 build iuplua-3.32-1.rockspec
sudo luarocks --lua-version 5.4 build iuplua-cd-3.32-1.rockspec
sudo luarocks --lua-version 5.4 build iuplua-im-3.32-1.rockspec
sudo luarocks --lua-version 5.4 build iuplua-gl-3.32-1.rockspec
sudo luarocks --lua-version 5.4 build iuplua-examples-0.1-1.rockspec
sudo luarocks --lua-version 5.4 build iuplua-all-3.32-1.rockspec
```

Verify all 14 modules:

```sh
lua5.4 examples/all.lua
```

## Packages

| Rockspec | Description | Build |
|----------|-------------|-------|
| `iuplua` | IUP core + Lua bindings | tarball (IUP 3.32) |
| `iuplua-cd` | Canvas Draw + Lua bindings | tarball (CD 5.14) |
| `iuplua-im` | Image toolkit + Lua bindings | tarball (IM 3.15) |
| `iuplua-gl` | OpenGL canvas (meta-package) | none |
| `iuplua-examples` | 132 Lua examples | git clone |
| `iuplua-all` | All of the above | meta-package |

## Require Order

Bridge modules (`iupluacd`, `iupluaim`) require their base
bindings loaded first. Always use this order:

```lua
require "iuplua"
require "cdlua"       -- before iupluacd
require "imlua"       -- before iupluaim
require "iupluacd"
require "iupluaim"
require "iupluagl"
require "iupluacontrols"
require "iupluaimglib"
```

Loading bridge modules without their base binding causes
segfaults due to duplicate library loading by the dynamic
linker.

## Examples

```sh
luarocks --lua-version 5.4 build iuplua-examples-0.1-1.rockspec
lua5.4 examples/all.lua
lua5.4 examples/7gui/counter.lua
```

132 examples organized into:

| Directory            | Description                    | Count |
|----------------------|--------------------------------|-------|
| `examples/tutorial/` | Progressive tutorial (Ch.2-4)  | 23    |
| `examples/7gui/`     | 7GUIs benchmark                | 7     |
| `examples/basic/`    | Basic Guide to IupLua          | 23    |
| `examples/elements/` | Per-widget standalone examples | 79    |

See [examples/README.md](examples/README.md) for details.

## For Maintainers

### Repackaging

Each Tecgraf library has a repack script that downloads core +
Lua binding tarballs from SourceForge, adds a Makefile, and
creates a combined tarball:

```sh
bash repack.sh 54 Linux515_64         # IUP 3.32
bash repack-cd.sh 54 Linux515_64      # CD 5.14
bash repack-im.sh 54 Linux515_64      # IM 3.15
```

Upload to the GitHub release:

```sh
gh release upload v3.32 iuplua-3.32-*.tar.gz --clobber
gh release upload v3.32 iuplua-cd-3.32-*.tar.gz --clobber
gh release upload v3.32 iuplua-im-3.32-*.tar.gz --clobber
```

### How the Makefiles Work

Each tarball contains a Makefile that:

1. Installs core C libs (e.g., `libiup.so`) to `/usr/local/lib/`
2. Installs Lua binding originals (e.g., `libiuplua54.so`) to
   `/usr/local/lib/`
3. Creates symlinks with short names (e.g.,
   `iuplua.so -> /usr/local/lib/libiuplua54.so`) in
   `/usr/local/lib/lua/5.4/`

Symlinks are used instead of copies because:
- The dynamic linker identifies libraries by file identity
- Copies create separate identities, causing duplicate loading
- Duplicate loading of IUP/CD/IM Lua bindings causes segfaults
- Symlinks are created directly in `/usr/local/lib/lua/5.4/`
  (hardcoded) because luarocks dereferences symlinks during
  its deploy step

### Testing Locally

```sh
sudo luarocks --lua-version 5.4 build iuplua-3.32-1.rockspec
lua5.4 -e 'require "iuplua"; print(iup.Version())'
```

### Git Tags

Sub-packages reference these tags in their `source.url`:
- `v3.32` — used by `iuplua-cd`, `iuplua-im`, `iuplua-gl`,
  `iuplua-all`
- `v0.1` — used by `iuplua-examples`

Update tags after pushing changes:

```sh
git tag -f v3.32
git tag -f v0.1
git push origin --force refs/tags/v3.32 refs/tags/v0.1
```

### Manual Alternative (without LuaRocks)

```sh
lua5.4 setup.lua --check
sudo lua5.4 setup.lua --link
```

## References

- IUP homepage: https://iup.sourceforge.net/
- IUP tutorial: https://iup.sourceforge.net/en/tutorial/tutorial1.html
- 7GUIs benchmark: https://iup.sourceforge.net/en/7gui/7gui.html
- Basic Guide: https://iup.sourceforge.net/en/basic/index.html
- CD homepage: https://cd.sourceforge.net/
- IM homepage: https://im.sourceforge.net/

## License

MIT - See [LICENSE](LICENSE)
