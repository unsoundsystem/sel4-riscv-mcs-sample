cmake_minimum_required(VERSION 3.7.2)

set(project_dir "${CMAKE_CURRENT_LIST_DIR}/..")
list(APPEND CMAKE_MODULE_PATH
        ${project_dir}/seL4
        ${project_dir}/libs/musllibc
        ${project_dir}/libs/sel4runtime
        ${project_dir}/libs/util_libs
        ${project_dir}/tools/cmake-tool/helpers/
        ${project_dir}/tools/elfloader-tool/
)
message(STATUS "cmake modules path" ${CMAKE_MODULE_PATH})

set(OPENSBI_PATH "${project_dir}/tools/opensbi" CACHE STRING "OpenSBI Folder location")

#set(KernelArch riscv)
#set(KernelSel4ArchRiscV64 TRUE)
#set(KernelWordSize 64)
set(KernelIsMCS ON)
set(KernelMCS TRUE)
set(PLATFORM spike)
ApplyCommonReleaseVerificationSettings(OFF OFF)

include(application_settings)

correct_platform_strings()
