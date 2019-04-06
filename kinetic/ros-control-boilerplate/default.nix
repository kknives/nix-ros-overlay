
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, controller-manager, hardware-interface, cmake-modules, control-msgs, gflags, trajectory-msgs, joint-limits-interface, catkin, control-toolbox, sensor-msgs, urdf, actionlib, std-msgs, rosparam-shortcuts, roscpp, transmission-interface }:
buildRosPackage {
  pname = "ros-kinetic-ros-control-boilerplate";
  version = "0.4.1";

  src = fetchurl {
    url = https://github.com/davetcoleman/ros_control_boilerplate-release/archive/release/kinetic/ros_control_boilerplate/0.4.1-0.tar.gz;
    sha256 = "549a61a022dc82b3c28a2fa180a965a35cf74e171e937a56b0e1466dcd2a679a";
  };

  propagatedBuildInputs = [ controller-manager hardware-interface control-msgs control-toolbox trajectory-msgs joint-limits-interface sensor-msgs urdf actionlib std-msgs rosparam-shortcuts roscpp transmission-interface ];
  nativeBuildInputs = [ controller-manager hardware-interface cmake-modules gflags control-msgs control-toolbox trajectory-msgs joint-limits-interface sensor-msgs catkin urdf actionlib std-msgs rosparam-shortcuts roscpp transmission-interface ];

  meta = {
    description = ''Simple simulation interface and template for setting up a hardware interface for ros_control'';
    #license = lib.licenses.BSD;
  };
}