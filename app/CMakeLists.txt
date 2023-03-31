cmake_minimum_required(VERSION 3.7.2)

project(sel4sample-main C)
add_executable(sel4sample-main main.c)
target_link_libraries(sel4sample-main
    sel4_autoconf
    sel4muslcsys
    muslc
    sel4
    sel4runtime
    sel4utils
    sel4platsupport sel4utils sel4debug
    sel4allocman sel4vka
    )
target_compile_options(sel4sample-main PRIVATE -Werror -g)
include(rootserver)
DeclareRootserver(sel4sample-main)
