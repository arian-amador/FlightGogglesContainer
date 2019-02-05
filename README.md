Flight Goggles Container
========================

A Linux container running Unity3D & Flight Goggles ROS framework

*Note: nvidia-docker2 and cuda >= 10.0 is required to run this container.*

# Build

```
$] git clone https://github.com/arian-amador/FlightGogglesContainer
$] sudo docker build -t flight-goggles FlightGogglesContainer
```

# Run

For a GUI Application to run, an XServer is needed which is not available inside the container.

In order to share the hosts XServer with the container use the following flags.

 - -v "$HOME/.Xauthority:/root/.Xauthority:rw"
 - -e DISPLAY

In order to share the hosts network stack with the container use the following flag.
 - --net=host
 
In order to share the hosts GPU with the container use the follow flag.
 - --runtime=nvidia

```
$] sudo docker run --runtime=nvidia --network=host -ti --rm -e DISPLAY -v "$HOME/.Xauthority:/root/.Xauthority:rw" flight-goggles:latest
```

# Resources
 - Nvidia Docker: https://github.com/NVIDIA/nvidia-docker
 - Nvidia+OpenGL images: https://hub.docker.com/r/nvidia/opengl/
 - Unity3D Docker install: https://github.com/thomasquintana/AirSimContainer
 - FlightGoggles framework: https://github.com/AgileDrones/FlightGoggles
