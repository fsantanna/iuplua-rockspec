rockspec_format = "3.0"
package = "iuplua"
version = "3.32-1"

source = {
    url = "https://downloads.sourceforge.net/project/iup"
        .. "/3.32/Linux%20Libraries/Lua54"
        .. "/iup-3.32-Lua54_Linux515_64_lib.tar.gz",
    dir = ".",
}

description = {
    summary = "IUP Lua binding - portable GUI toolkit"
        .. " (Tecgraf/PUC-Rio)",
    detailed = [[
        IUP is a multi-platform toolkit for building
        graphical user interfaces. It uses native controls
        and has a simple API.

        This rockspec installs the precompiled Lua 5.4
        bindings from the official Tecgraf distribution.

        The IUP core C libraries must be installed
        separately. Precompiled binaries available at:
        https://sourceforge.net/projects/iup/files/
    ]],
    homepage = "https://iup.sourceforge.net/",
    license = "MIT",
    labels = {
        "iup", "gui", "toolkit", "tecgraf", "native",
    },
}

supported_platforms = {
    "linux",
}

dependencies = {
    "lua >= 5.4, < 5.5",
}

external_dependencies = {
    IUP = {
        header = "iup.h",
        library = "iup",
    },
}

build = {
    type = "none",
    install = {
        lib = {
            ["iuplua"] =
                "libiuplua54.so",
            ["iupluacd"] =
                "libiupluacd54.so",
            ["iupluacontrols"] =
                "libiupluacontrols54.so",
            ["iupluagl"] =
                "libiupluagl54.so",
            ["iupluaglcontrols"] =
                "libiupluaglcontrols54.so",
            ["iupluaim"] =
                "libiupluaim54.so",
            ["iupluaimglib"] =
                "libiupluaimglib54.so",
            ["iuplua_mglplot"] =
                "libiuplua_mglplot54.so",
            ["iuplua_plot"] =
                "libiuplua_plot54.so",
            ["iuplua_scintilla"] =
                "libiuplua_scintilla54.so",
            ["iupluascripterdlg"] =
                "libiupluascripterdlg54.so",
            ["iupluatuio"] =
                "libiupluatuio54.so",
            ["iupluaweb"] =
                "libiupluaweb54.so",
        },
    },
}
