FROM ubuntu:22.04
WORKDIR /build-toolchain
RUN apt-get update && \
    apt-get install -y git autoconf automake autotools-dev \
        curl python3 libmpc-dev libmpfr-dev libgmp-dev \
        gawk build-essential bison flex texinfo gperf libtool \
        patchutils bc zlib1g-dev libexpat-dev ninja-build
RUN git clone https://github.com/riscv/riscv-gnu-toolchain.git riscv-gnu-toolchain && \
        cd riscv-gnu-toolchain && \
        git submodule update --init --recursive && \
        mkdir -p /opt/riscv && \
        ./configure --prefix="/opt/riscv" --enable-multilib && \
        make -j$(nproc) linux

# Next stage (copying binaries)
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y gcc device-tree-compiler

ENV TZ=Asia/Tokyo

ENV RISCV=/opt/riscv
ENV PATH=$RISCV/bin:$PATH

COPY --from=0 /opt/riscv/ /opt/riscv
