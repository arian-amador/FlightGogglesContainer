# Flight Goggles Container

A Linux container running Unity3D & Flight Goggles ROS framework

_Note: nvidia-docker2 and cuda >= 10.0 is required to run this container._

# Build framework and client

```
git clone https://github.com/arian-amador/FlightGogglesContainer
cd FlightGogglesContainer
sudo docker build -t flight-goggles Framework
```

# Run

### Docker Specifics

For a GUI Application to run, an XServer is needed which is not available inside the container.

Share the hosts XServer with the container use the following flags.

- -v "\$HOME/.Xauthority:/root/.Xauthority:rw"
- -e DISPLAY

Share the hosts network stack with the container use the following flag.

- --net=host

Share the hosts GPU with the container use the follow flag.

- --runtime=nvidia

Share the hosts IPC namespace for shared memory space.

- --ipc=host

Share the hosts Vulkan config and module.
The module below will vary dependin on the hosts Nvidia drivers.

- -v /usr/share/vulkan/icd.d:/usr/share/vulkan/icd.d
- -v /usr/lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.410.48:/usr/lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.410.48

### Framework

```
docker run \
  --rm \
  --runtime=nvidia \
  --network=host \
  -e DISPLAY \
  -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
  -v /usr/share/vulkan/icd.d:/usr/share/vulkan/icd.d \
  -v /usr/lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.410.48:/usr/lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.410.48 \ flight-goggles:latest /bin/bash -c "/root/bin/execute.sh"
```

# Resources

- Nvidia Docker: https://github.com/NVIDIA/nvidia-docker
- Nvidia+OpenGL images: https://hub.docker.com/r/nvidia/opengl/
- Unity3D Docker install: https://github.com/thomasquintana/AirSimContainer
- FlightGoggles: https://github.com/mit-fast/FlightGoggles
- Catkin Tools: https://catkin-tools.readthedocs.io/en/latest/index.html
- Kinetic: http://wiki.ros.org/kinetic/
