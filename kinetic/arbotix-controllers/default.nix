
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, arbotix-python, trajectory-msgs, tf, catkin }:
buildRosPackage {
  pname = "ros-kinetic-arbotix-controllers";
  version = "0.10.0-r1";

  src = fetchurl {
    url = https://github.com/vanadiumlabs/arbotix_ros-release/archive/release/kinetic/arbotix_controllers/0.10.0-1.tar.gz;
    sha256 = "e460be8dd3bda74ed608dc292523b60b302fefed0cd4e17c4b7f4152b76820fd";
  };

  propagatedBuildInputs = [ arbotix-python trajectory-msgs tf ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''Extends the arbotix_python package with a number of more sophisticated ROS wrappers for common devices.'';
    #license = lib.licenses.BSD;
  };
}