cmake_minimum_required(VERSION 3.7.2)
include(settings.cmake)

find_package(seL4 REQUIRED)
find_package(elfloader-tool REQUIRED)
find_package(musllibc REQUIRED)
find_package(sel4runtime REQUIRED)

sel4_configure_platform_settings()

project(sel4sample C CXX ASM)

set(KERNEL_PATH ../seL4)
# Set the roottask CNode size to be large enough for DTB, timer caps, etc
# Note that this works for the platforms that we have at the moment, and may
# need to be increased in the future
set(KernelRootCNodeSizeBits 13 CACHE INTERNAL "")

include(../tools/cmake-tool/base.cmake)

add_subdirectory(../libs/sel4runtime sel4runtime)
add_subdirectory(../libs/musllibc musllibc)
add_subdirectory(../libs/util_libs util_libs)
add_subdirectory(../libs/seL4_libs seL4_libs)
add_subdirectory(app)

if(SIMULATION)
    ApplyCommonSimulationSettings(${KernelSel4Arch})
    GenerateSimulateScript()
endif()
