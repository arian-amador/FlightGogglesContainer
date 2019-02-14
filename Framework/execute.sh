#!/bin/bash
source /opt/ros/kinetic/setup.bash
source /root/catkin_ws/devel/setup.bash

echo "Running launcher"
`python /opt/ros/kinetic/bin/roslaunch flightgoggles teleopExample.launch ignore_collisions:=1`