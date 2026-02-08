-- Ensures all IupLua modules are installed.
-- Asserts on failure so it can be used as a sanity check.

local modules = {
    { name = "iuplua",           desc = "core" },
    { name = "iupluacd",         desc = "Canvas Draw" },
    { name = "iupluaim",         desc = "Image" },
    { name = "iupluagl",         desc = "OpenGL" },
    { name = "iupluacontrols",   desc = "controls" },
    { name = "iupluaimglib",     desc = "image library" },
    { name = "iuplua_plot",      desc = "plot" },
    { name = "iuplua_mglplot",   desc = "MathGL plot" },
    { name = "iuplua_scintilla", desc = "Scintilla" },
    { name = "iupluatuio",       desc = "TUIO" },
    { name = "iupluaweb",        desc = "web browser" },
    { name = "iupluaglcontrols", desc = "GL controls" },
}

local failed = {}

for _, mod in ipairs(modules) do
    local ok, err = pcall(require, mod.name)
    if ok then
        print("[ok]   " .. mod.name
            .. " (" .. mod.desc .. ")")
    else
        print("[FAIL] " .. mod.name
            .. " (" .. mod.desc .. ")")
        failed[#failed + 1] = mod.name
    end
end

print()
print("Total: " .. #modules
    .. ", OK: " .. (#modules - #failed)
    .. ", Failed: " .. #failed)

assert(#failed == 0,
    "missing modules: " .. table.concat(failed, ", "))
