#!/usr/bin/env lua
-- setup.lua: Helper to verify IUP installation and create
-- symlinks so `require "iuplua"` works from LuaRocks.
--
-- Usage:
--   lua setup.lua [--check] [--link]
--
-- Options:
--   --check   Verify IUP libraries are found
--   --link    Create symlinks in Lua cpath (needs sudo)
--
-- The IUP precompiled binaries install libraries named
-- like `libiuplua54.so`, but Lua's `require "iuplua"`
-- expects `iuplua.so` in package.cpath.

local lua_version = _VERSION:match("(%d+%.%d+)")
local lua_suffix = lua_version:gsub("%.", "")

local modules = {
    { name = "iuplua",         lib = "iuplua" },
    { name = "iupluacd",       lib = "iupluacd" },
    { name = "iupluacontrols", lib = "iupluacontrols" },
    { name = "iupluagl",       lib = "iupluagl" },
    { name = "iupluaglcontrols",
        lib = "iupluaglcontrols" },
    { name = "iupluaim",       lib = "iupluaim" },
    { name = "iupluaimglib",   lib = "iupluaimglib" },
    { name = "iuplua_mglplot", lib = "iuplua_mglplot" },
    { name = "iuplua_plot",    lib = "iuplua_plot" },
    { name = "iuplua_scintilla",
        lib = "iuplua_scintilla" },
    { name = "iupluatuio",     lib = "iupluatuio" },
    { name = "iupluaweb",      lib = "iupluaweb" },
}

local lib_dirs = {
    "/usr/lib",
    "/usr/local/lib",
    "/usr/lib64",
    "/usr/local/lib64",
}

local function find_lib(base)
    local name = "lib" .. base .. lua_suffix .. ".so"
    for _, dir in ipairs(lib_dirs) do
        local path = dir .. "/" .. name
        local f = io.open(path, "r")
        if f then
            f:close()
            return path
        end
    end
    return nil
end

local function find_lua_cpath()
    for path in package.cpath:gmatch("[^;]+") do
        local dir = path:match("(.+)/")
        if dir then
            local f = io.open(dir, "r")
            if f then
                f:close()
                return dir
            end
        end
    end
    return nil
end

local function check()
    print("IUP installation check")
    print("Lua version: " .. lua_version
        .. " (suffix: " .. lua_suffix .. ")")
    print()

    local found, missing = 0, 0
    for _, mod in ipairs(modules) do
        local path = find_lib(mod.lib)
        if path then
            print("  [ok]    " .. mod.name
                .. " -> " .. path)
            found = found + 1
        else
            print("  [miss]  " .. mod.name)
            missing = missing + 1
        end
    end

    print()
    print("Found: " .. found
        .. ", Missing: " .. missing)

    if found == 0 then
        print()
        print("IUP not found. Install from:")
        print("  https://sourceforge.net/projects"
            .. "/iup/files/")
    end

    return found > 0
end

local function link()
    local cpath = find_lua_cpath()
    if not cpath then
        print("Error: could not find Lua cpath")
        os.exit(1)
    end

    print("Creating symlinks in: " .. cpath)
    print()

    local created = 0
    for _, mod in ipairs(modules) do
        local src = find_lib(mod.lib)
        if src then
            local dst = cpath .. "/" .. mod.name .. ".so"
            local cmd = 'ln -sf "' .. src
                .. '" "' .. dst .. '"'
            local ok = os.execute(cmd)
            if ok then
                print("  " .. mod.name .. ".so -> "
                    .. src)
                created = created + 1
            else
                print("  FAIL: " .. mod.name)
            end
        end
    end

    print()
    print("Created " .. created .. " symlinks")
    if created > 0 then
        print('Try: lua -e \'require "iuplua"\'')
    end
end

local arg = arg or {}
if #arg == 0 or arg[1] == "--check" then
    check()
elseif arg[1] == "--link" then
    if check() then
        print()
        link()
    end
else
    print("Usage: lua setup.lua [--check|--link]")
end
