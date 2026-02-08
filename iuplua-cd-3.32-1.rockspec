rockspec_format = "3.0"
package = "iuplua-cd"
version = "3.32-1"

source = {
    url = "git+https://github.com/fsantanna/iuplua-rockspec.git",
    tag = "v3.32",
}

description = {
    summary = "IUP Canvas Draw binding for Lua (Tecgraf/PUC-Rio)",
    detailed = [[
        CD (Canvas Draw) integration for IUP. Provides 2D
        drawing primitives on IUP canvases.

        Requires IUP and CD installed on the system.
        Precompiled binaries available at:
        https://sourceforge.net/projects/iup/files/
    ]],
    homepage = "https://iup.sourceforge.net/",
    license = "MIT",
    labels = { "iup", "cd", "canvas", "drawing", "tecgraf" },
}

supported_platforms = {
    "linux", "windows",
}

dependencies = {
    "lua >= 5.4, < 5.5",
    "iuplua == 3.32",
}

build = {
    type = "none",
}
