rockspec_format = "3.0"
package = "iuplua-gl"
version = "3.32-1"

source = {
    url = "git+https://github.com/fsantanna/iuplua-rockspec.git",
    tag = "v3.32",
}

description = {
    summary = "IUP OpenGL canvas binding for Lua (Tecgraf/PUC-Rio)",
    detailed = [[
        OpenGL integration for IUP. Provides IupGLCanvas for
        hardware-accelerated 3D rendering inside IUP dialogs.

        Requires IUP and OpenGL installed on the system.
        Precompiled binaries available at:
        https://sourceforge.net/projects/iup/files/
    ]],
    homepage = "https://iup.sourceforge.net/",
    license = "MIT",
    labels = { "iup", "opengl", "gl", "3d", "tecgraf" },
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
    GL = {
        header = "GL/gl.h",
        library = "GL",
    },
}

build = {
    type = "none",
}
