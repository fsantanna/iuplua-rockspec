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
3. [ ] Test with `luarocks lint` (manual step)

## Phase 3: Future (out of scope for now)

- Full `iuplua` rockspec that wraps the C library build
- Precompiled binary rocks per platform
- Separate sub-packages (iup-core, iup-cd, iup-im, iup-gl)

## References

- IUP homepage: https://iup.sourceforge.net/
- LuaRocks rockspec format: https://github.com/luarocks/luarocks/wiki/Rockspec-format
- IUP rockspec discussion: https://luarocks-developers.narkive.com/y5K1M6mJ/help-in-rockspec-for-iup-cd-and-im
- Creating a rock: https://github.com/luarocks/luarocks/wiki/creating-a-rock
