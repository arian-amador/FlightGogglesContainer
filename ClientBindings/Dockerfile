# docker build -t <container-tag> .
# docker run --runtime=nvidia --network=host -ti --rm -e DISPLAY -v "$HOME/.Xauthority:/root/.Xauthority:rw" --ipc host <container-tag>

FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04
ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="arian@arianamador.com"

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        build-essential \
        git-core \
        ca-certificates \
        libzmqpp-dev \
        libeigen3-dev \
        libopencv-dev \
        cmake
RUN rm -rf /var/lib/apt/lists/*

# Prepare FligtGoggles Client Bindings
WORKDIR /root
RUN git clone https://github.com/arian-amador/FlightGogglesClientBindings.git
RUN mkdir /root/FlightGogglesClientBindings/build

# Build
WORKDIR /root/FlightGogglesClientBindings/build
RUN cmake ../ && make

# Run
CMD /root/FlightGogglesClientBindings/build/bin/GeneralClient

