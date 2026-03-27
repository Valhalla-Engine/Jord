project "JordTests"
    kind "ConsoleApp"
    language "C++"
    targetdir ("../bin/" .. outputdir .. "/%{prj.name}")
    objdir ("../bin-int/" .. outputdir .. "/%{prj.name}")

    if useModules then
        cppdialect "C++20"
        defines { "JORD_USE_MODULES" }
    else
        cppdialect "C++17"
    end

    includedirs {
        "../Jord/include",  -- relative path to Jord headers
        "../external/googletest/googletest/include"
    }

    files { "src/**.cpp" }

    vpaths {
        ["Sources/*"] = { "src/**.cpp" }
    }

    links { "Jord", "gtest" }