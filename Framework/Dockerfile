FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04
LABEL maintainer="arian@arianamador.com"

# https://github.com/NVIDIA/nvidia-docker/wiki/Usage#dockerfiles
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display

# Set the Default RUN shell
SHELL ["/bin/bash", "-c"]

# Fixes readline errors during apt
ARG DEBIAN_FRONTEND=noninteractive

# Update and Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        lsb-release \
        ca-certificates \
        build-essential \
        python-pip \
        mesa-utils \
        mesa-vulkan-drivers \
        libarchive-dev \
        libzmqpp-dev \
        libeigen3-dev \
        libvulkan1 \
        vulkan-utils\
        lib32gcc1 \
        lib32stdc++6 \
        libboost-all-dev \
        libc6-i386 \
        libcairo2 \
        libcap2 \
        libcups2 \
        libdbus-1-3 \
        libfontconfig1 \
        libgconf-2-4 \
        libgdk-pixbuf2.0-0 \
        libgl1 \
        libgl1-mesa-glx \
        libglu1 \
        libgtk2.0-0 \
        libgtk2.0-dev \
        libgtk-3-dev \
        libnspr4 \
        libnss3 \
        libpango1.0-0 \
        libpq5 \
        libsoup2.4-dev \
        libx11-6 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        libxtst6

# Install/Setup Unity
WORKDIR /tmp
RUN wget https://beta.unity3d.com/download/6e9a27477296/UnitySetup-2018.3.0f2
RUN chmod +x UnitySetup-2018.3.0f2
RUN yes | ./UnitySetup-2018.3.0f2 --unattended --download-location=/tmp --install-location /opt/Unity -v
RUN rm -rf /tmp/*

# Install/Setup Kinetic Workspace with Catkin
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
RUN apt-get update && apt-get install -y \
        ros-kinetic-desktop \
        python-rosinstall \
        python-rosinstall-generator \
        python-catkin-tools

RUN rosdep init && rosdep update && pip install catkin_pkg
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
RUN source /root/.bashrc

# Setup FlightGoggles Packages and Workspace
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws
RUN catkin init

WORKDIR /root/catkin_ws/src
RUN wstool init
RUN wstool merge https://raw.githubusercontent.com/mit-fast/FlightGoggles/master/flightgoggles.rosinstall
RUN wstool update

WORKDIR /root/catkin_ws
RUN rosdep install --from-paths src --ignore-src --rosdistro kinetic -y
RUN echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc
RUN source /root/.bashrc
RUN catkin config --extend /opt/ros/kinetic
RUN catkin build

# Clean Up
RUN rm -rf /var/lib/apt/lists/*

# Copy Example execute script
RUN mkdir -p /root/bin
COPY execute.sh /root/bin/execute.sh
RUN chmod +x /root/bin/execute.sh