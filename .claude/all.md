# Plan: IupLua Rockspec

## Goal

Create a LuaRocks package (`iuplua-examples`) with all IUP Lua
examples from the official Tecgraf website, plus a proper rockspec
for future upload to the official LuaRocks repository.

Currently, **there is no official IupLua package on LuaRocks**.
The Tecgraf team explored it but IUP's complex build system made
it non-trivial. This project takes a practical approach: package
the Lua examples first, then evolve the rockspec.

## Phase 1: Examples (done)

Downloaded all Lua examples from `iup.sourceforge.net/examples/Lua/`
organized in the following directory tree:

```
examples/
├── tutorial/
│   ├── 2-hello/          -- Ch.2: Hello World (5 examples)
│   ├── 3-notepad/        -- Ch.3: Simple Notepad (12 examples)
│   └── 4-paint/          -- Ch.4: Simple Paint (6 examples)
├── 7gui/                 -- 7GUIs benchmark (7 examples)
├── basic/                -- Basic Guide to IupLua
│   ├── input/            -- iup.GetFile, iup.GetText, iup.GetParam
│   ├── dialogs/          -- multiline, button, vbox, hbox, frame, tabs
│   ├── timer/            -- timer1
│   ├── list/             -- list1, listdlg
│   ├── tree/             -- testtree2, testtree4, directory
│   ├── menu/             -- simple-menu, menu
│   ├── plot/             -- iupxplot, simple-plot
│   └── iupx.lua          -- shared utility module
└── elements/             -- 79 standalone per-widget examples
```

Note: `basic/output/` was dropped (iup.Message/iup.Alarm examples
were inline-only on the guide page, no downloadable files).

### Sources

- Elements (79 files): `iup.sourceforge.net/examples/Lua/*.lua`
- Tutorial: `iup.sourceforge.net/examples/tutorial/`
- 7GUIs: `iup.sourceforge.net/examples/Lua/7gui/`
- Basic Guide: `iup.sourceforge.net/examples/Lua/misc/`

### Steps

1. [x] Download all 79 element examples into `examples/elements/`
2. [x] Download tutorial examples (Ch.2, Ch.3, Ch.4)
3. [x] Download 7GUI examples
4. [x] Download basic guide examples
5. [x] Add a `README.md` for `examples/` explaining the structure

## Phase 2: Rockspec (done)

Created `iuplua-examples-0.1-1.rockspec` for LuaRocks.

### Approach

- `build.type = "none"` (pure Lua examples, no compilation)
- `copy_directories = { "examples" }`
- Dependencies: `lua >= 5.1`

### Steps

1. [x] Create the rockspec file
2. [x] Update root `README.md` with install instructions
3. [x] Test with `luarocks lint`

## Phase 3: Rockspecs + Setup (done)

Created rockspecs for IUP and its sub-packages, plus a setup
helper script.

### Rockspecs

| File | Package | External deps |
|------|---------|---------------|
| `iuplua-3.32-1.rockspec` | iuplua (core) | iup.h, libiup |
| `iuplua-cd-3.32-1.rockspec` | iuplua-cd | + cd.h, libcd |
| `iuplua-im-3.32-1.rockspec` | iuplua-im | + im.h, libim |
| `iuplua-gl-3.32-1.rockspec` | iuplua-gl | + GL/gl.h, libGL |

All use `build.type = "none"` with `external_dependencies`
to validate the C libraries are installed. Sub-packages depend
on `iuplua >= 3.32`.

### Setup helper

`setup.lua` -- verifies IUP installation and creates symlinks
so `require "iuplua"` works:
- `lua setup.lua --check` -- detect installed IUP libraries
- `lua setup.lua --link`  -- create symlinks in Lua cpath

### Steps

1. [x] Create `iuplua-3.32-1.rockspec` (core)
2. [x] Create `iuplua-cd-3.32-1.rockspec`
3. [x] Create `iuplua-im-3.32-1.rockspec`
4. [x] Create `iuplua-gl-3.32-1.rockspec`
5. [x] Create `setup.lua` helper
6. [x] Test with `luarocks lint`

## References

- IUP homepage: https://iup.sourceforge.net/
- LuaRocks rockspec format: https://github.com/luarocks/luarocks/wiki/Rockspec-format
- IUP rockspec discussion: https://luarocks-developers.narkive.com/y5K1M6mJ/help-in-rockspec-for-iup-cd-and-im
- Creating a rock: https://github.com/luarocks/luarocks/wiki/creating-a-rock
