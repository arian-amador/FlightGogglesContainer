# docker build -t <container-tag> .
# docker run --runtime=nvidia --network=host -ti --rm -e DISPLAY -v "$HOME/.Xauthority:/root/.Xauthority:rw" --ipc host <container-tag>

FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04
ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="arian@arianamador.com"

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        mesa-utils \
        ca-certificates \
        wget \
        libarchive-dev \
        libgtk2.0-dev \
        libgtk-3-dev
RUN rm -rf /var/lib/apt/lists/*

# Install Unity
WORKDIR /tmp
RUN wget https://beta.unity3d.com/download/6e9a27477296/UnitySetup-2018.3.0f2
RUN chmod +x UnitySetup-2018.3.0f2
RUN yes | ./UnitySetup-2018.3.0f2 --unattended --download-location=/tmp --install-location /opt/Unity -v
RUN rm -rf /tmp/*

# Prepare FligtGoggles
WORKDIR /root
RUN wget https://github.com/AgileDrones/FlightGoggles/releases/download/untagged-cfc4db08b42e68a4c1cf/FlightGoggles_v1.5.6_stable_Linux_64.tar.gz
RUN tar xzvf FlightGoggles_v1.5.6_stable_Linux_64.tar.gz
RUN rm FlightGoggles_v1.5.6_stable_Linux_64.tar.gz

# Run
CMD /root/FlightGoggles_v1.5.6_stable_Linux_64.x86_64
