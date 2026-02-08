rockspec_format = "3.0"
package = "iuplua-im"
version = "3.32-1"

source = {
    url = "git+https://github.com/fsantanna/iuplua-rockspec.git",
    tag = "v3.32",
}

description = {
    summary = "IUP Image library binding for Lua (Tecgraf/PUC-Rio)",
    detailed = [[
        IM (Image) integration for IUP. Provides image loading,
        processing, and display on IUP dialogs.

        Requires IUP and IM installed on the system.
        Precompiled binaries available at:
        https://sourceforge.net/projects/iup/files/
    ]],
    homepage = "https://iup.sourceforge.net/",
    license = "MIT",
    labels = { "iup", "im", "image", "tecgraf" },
}

supported_platforms = {
    "linux", "windows",
}

dependencies = {
    "lua >= 5.1",
    "iuplua >= 3.32",
}

external_dependencies = {
    IUP = {
        header = "iup.h",
        library = "iup",
    },
    IM = {
        header = "im.h",
        library = "im",
    },
}

build = {
    type = "none",
}
