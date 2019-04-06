
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, actionlib-msgs, sensor-msgs, catkin, message-generation, message-runtime, std-msgs, geometry-msgs }:
buildRosPackage {
  pname = "ros-kinetic-darknet-ros-msgs";
  version = "1.1.4";

  src = fetchurl {
    url = https://github.com/leggedrobotics/darknet_ros-release/archive/release/kinetic/darknet_ros_msgs/1.1.4-0.tar.gz;
    sha256 = "2088c1b767d52a39c01cf1271de48634287963f13749eec570e9a4521f32986b";
  };

  propagatedBuildInputs = [ message-runtime actionlib-msgs std-msgs sensor-msgs geometry-msgs ];
  nativeBuildInputs = [ message-generation actionlib-msgs std-msgs sensor-msgs catkin geometry-msgs ];

  meta = {
    description = ''Darknet is an open source neural network framework that runs on CPU and GPU. You only look once (YOLO) is a state-of-the-art, real-time object detection system.'';
    #license = lib.licenses.BSD;
  };
}