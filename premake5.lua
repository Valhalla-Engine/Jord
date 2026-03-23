newoption {
    trigger     = "with-tests",
    description = "Build Jord tests"
}

workspace "Jord"
    architecture "x64"
    configurations { "Debug", "Release" }

project "Jord"
    kind "StaticLib"
    language "C++"
    files { "src/**.cpp", "include/Jord/**.h" }
    includedirs { "include" }

if _OPTIONS["with-tests"] then
    project "JordTests"
        kind "ConsoleApp"
        language "C++"
        files { "tests/**.cpp", "tests/**.h" }
        includedirs { "include", "external/googletest/include" }
        links { "Jord", "gtest", "gtest_main" }
end