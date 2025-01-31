cmake_minimum_required(VERSION 3.15)

project(msdf-atlas-gen VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(msdf-atlas-gen STATIC)

set(OUTPUT_DIR "${CMAKE_BINARY_DIR}/bin")
set_target_properties(msdf-atlas-gen PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${OUTPUT_DIR}"
    LIBRARY_OUTPUT_DIRECTORY "${OUTPUT_DIR}"
    RUNTIME_OUTPUT_DIRECTORY "${OUTPUT_DIR}"
)

file(GLOB_RECURSE MSDF_ATLAS_GEN_SRC "msdf-atlas-gen/**.cpp")
file(GLOB_RECURSE MSDF_ATLAS_GEN_HDR "msdf-atlas-gen/**.h" "msdf-atlas-gen/**.hpp")
file(GLOB_RECURSE ARTERY_FONT_HDR "artery-font-format/artery-font/**.h" "artery-font-format/artery-font/**.hpp")

target_sources(msdf-atlas-gen PRIVATE ${MSDF_ATLAS_GEN_SRC} ${MSDF_ATLAS_GEN_HDR} ${ARTERY_FONT_HDR})

target_include_directories(msdf-atlas-gen PRIVATE
    "msdf-atlas-gen"
    "msdfgen/core"
    "msdfgen/ext"
    "msdfgen"
    "artery-font-format"
)

target_compile_definitions(msdf-atlas-gen PRIVATE _CRT_SECURE_NO_WARNINGS)

add_subdirectory(msdfgen)
target_link_libraries(msdf-atlas-gen PRIVATE msdfgen)
target_include_directories(${PROJECT_NAME} PUBLIC msdfgen)

if(WIN32)
    target_compile_definitions(msdf-atlas-gen PRIVATE WINDOWS)
endif()

set_target_properties(msdf-atlas-gen PROPERTIES DEBUG_POSTFIX "_d")

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_definitions(msdf-atlas-gen PRIVATE DEBUG)
    target_compile_options(msdf-atlas-gen PRIVATE -g)
elseif(CMAKE_BUILD_TYPE STREQUAL "Release" OR CMAKE_BUILD_TYPE STREQUAL "Dist")
    target_compile_definitions(msdf-atlas-gen PRIVATE NDEBUG)
    target_compile_options(msdf-atlas-gen PRIVATE -O2)
endif()
