-- premake5.lua
-- created by muhhae

include ("staticlib.lua") --for vcpkg to choose static library for linking

workspace "App"
    configurations { "Debug", "Release" }
    platforms { "x64" }

project "App"
    language "C++" --Languange

    cppdialect "C++latest"
    systemversion "latest" --latest version for windows

    links {
        "gdi32",
        "winmm"
    } 

    targetdir "bin/%{cfg.buildcfg}" 
    objdir "obj/%{cfg.buildcfg}"

    files { 
        "App/**.cpp",
    }

    includedirs {
        "App",
    }
    defines {
        "SFML_STATIC"
    }

    characterset ("Unicode") --unicode for windows
    staticruntime "On" --static runtime for msvc
    dpiawareness "High" --dpi awareness for windows

    flags {
        "MultiProcessorCompile" --multi processor compile for msvc
    }

    filter "configurations:Debug"
        kind "ConsoleApp"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        kind "WindowedApp"
        entrypoint "mainCRTStartup"
        defines { "NDEBUG" }
        optimize "On"
        postbuildcommands {
            "{COPY} %{wks.location}Resources %{cfg.targetdir}/Resources"
        }