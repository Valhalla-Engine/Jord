project "Jord"
    kind "StaticLib"
    language "C++"
    targetdir ("../bin/" .. outputdir .. "/%{prj.name}")
    objdir ("../bin-int/" .. outputdir .. "/%{prj.name}")

    if useModules then
        cppdialect "C++20"
        defines { "JORD_USE_MODULES" }
    else
        cppdialect "C++17"
    end

    includedirs { "include" }  -- relative to Jord/ folder

    files {
        "include/**.h",
        "include/**.hpp",
        "src/**.cpp",
    }

    if useModules then
        files { "src/**.ixx" }
    end

    vpaths {
        ["Headers/*"] = { "include/**.h", "include/**.hpp" },
        ["Sources/*"] = { "src/**.cpp", "src/**.ixx" }
    }

    filter "action:vs2026"
        scanformoduledependencies "on"