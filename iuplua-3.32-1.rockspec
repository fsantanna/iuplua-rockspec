rockspec_format = "3.0"
package = "iuplua"
version = "3.32-1"

source = {
    url = "git+https://github.com/fsantanna/iuplua-rockspec.git",
    tag = "v3.32",
}

description = {
    summary = "IUP Lua binding - portable GUI toolkit (Tecgraf/PUC-Rio)",
    detailed = [[
        IUP is a multi-platform toolkit for building graphical
        user interfaces. It uses native controls and has a
        simple API.

        This rockspec validates that IUP is installed on the
        system and makes `require "iuplua"` discoverable
        through LuaRocks.

        IUP must be installed separately. Precompiled binaries
        are available at:
        https://sourceforge.net/projects/iup/files/
    ]],
    homepage = "https://iup.sourceforge.net/",
    license = "MIT",
    labels = {
        "iup", "gui", "toolkit", "tecgraf", "native",
    },
}

supported_platforms = {
    "linux", "windows",
}

dependencies = {
    "lua >= 5.1",
}

external_dependencies = {
    IUP = {
        header = "iup.h",
        library = "iup",
    },
}

build = {
    type = "none",
    copy_directories = { "examples" },
}
