include "msdfgen"

project "msdf-atlas-gen"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
    staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"msdf-atlas-gen/**.h",
    	"msdf-atlas-gen/**.hpp",
    	"msdf-atlas-gen/**.cpp",
        "artery-font-format/artery-font/**.h",
        "artery-font-format/artery-font/**.hpp",
	}

	includedirs
	{
		"msdf-atlas-gen",
		"msdfgen/core",
		"msdfgen/ext",
		"msdfgen",
		"artery-font-format",
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	links
	{
		"msdfgen"
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		runtime "Release"
		optimize "on"
        symbols "off"