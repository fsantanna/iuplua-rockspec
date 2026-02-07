# IupLua Examples

All examples are from the official IUP documentation at
[iup.sourceforge.net](https://iup.sourceforge.net/).

## Directory Structure

```
examples/
├── tutorial/         -- Progressive tutorial
│   ├── 2-hello/      -- Ch.2: Hello World (5 examples)
│   ├── 3-notepad/    -- Ch.3: Simple Notepad (12 examples)
│   └── 4-paint/      -- Ch.4: Simple Paint (6 examples)
├── 7gui/             -- 7GUIs benchmark (7 examples)
├── basic/            -- Basic Guide to IupLua (23 examples)
│   ├── input/        -- iup.GetFile, GetText, GetParam
│   ├── dialogs/      -- dialog, frame, tabs, canvas
│   ├── timer/        -- timer, idle
│   ├── list/         -- list, listdlg
│   ├── tree/         -- tree, directory browser
│   ├── menu/         -- simple and recursive menus
│   └── plot/         -- plotting examples
└── elements/         -- Per-widget standalone examples (79)
```

## Running

You need IUP installed on your system. Then run any example with:

```sh
lua examples/elements/button.lua
```

Or using the IupLua standalone executable:

```sh
iuplua examples/elements/button.lua
```

## Sources

- **elements/**: https://iup.sourceforge.net/examples/Lua/
- **tutorial/**: https://iup.sourceforge.net/en/tutorial/
- **7gui/**: https://iup.sourceforge.net/en/7gui/7gui.html
- **basic/**: https://iup.sourceforge.net/en/basic/index.html
  (files from the `misc/` subfolder)
