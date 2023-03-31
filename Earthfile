VERSION 0.7
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

WORKDIR /sel4simple

pre-build:
    FROM sasusesoiwasi/prebuilt-riscv-gnu-toolchain
    RUN apt-get update && \
        apt-get install -y build-essential \
            cmake ccache ninja-build cmake-curses-gui \
            libxml2-utils ncurses-dev \
            curl git doxygen device-tree-compiler \
            u-boot-tools \
            python3-dev python3-pip python-is-python3 \
            protobuf-compiler python3-protobuf \
            qemu-kvm qemu-system-misc cpio
    RUN pip3 install --user setuptools sel4-deps

build:
    FROM +pre-build
    COPY seL4 seL4
    COPY tools tools
    COPY sel4simple sel4simple
    COPY --dir libs libs
    #COPY --dir +build-riscv-toolchain/riscv-toolchain .
    ENV PATH /sel4simple/riscv-toolchain/bin:$PATH
    RUN echo $PATH && cd sel4simple && \
        # rm for prevent usage for build/ copied from out of Earthly build
        rm -rf build && mkdir build && cd build && \
        cmake .. -DCMAKE_BUILD_TYPE=Debug \
            -DCMAKE_TOOLCHAIN_FILE=../seL4/gcc.cmake \
            -DCROSS_COMPILER_PREFIX=riscv64-unknown-linux-gnu- --debug-output \
            -DKERNEL_PATH=../seL4 -DSIMULATION=TRUE -G Ninja
    RUN cd sel4simple/build && ninja
    SAVE ARTIFACT sel4simple/build AS LOCAL cmake_result
    SAVE IMAGE sel4simple-dev
