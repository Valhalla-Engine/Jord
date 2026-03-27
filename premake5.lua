workspace "Jord"
    architecture "x64"
    startproject "JordTests"
    configurations { "Debug", "Release" }

newoption {
    trigger = "use-modules",
    description = "Use C++20 modules instead of C++17 headers",
    allowed = {
        { "on", "C++20 modules" },
        { "off", "C++17 headers" }
    }
}
useModules = _OPTIONS["use-modules"] == "on"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"


-- Include Jord library and test projects
include "Jord/premake5.lua"
include "JordTests/premake5.lua"

-- -------------------------------
-- GoogleTest project in the root
project "gtest"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    includedirs {
        "external/googletest/googletest/include",
        "external/googletest/googletest"
    }

    files {
        "external/googletest/googletest/src/gtest-all.cc",
        "external/googletest/googletest/src/gtest_main.cc"
    }