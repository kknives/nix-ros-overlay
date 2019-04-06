
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, camera-info-manager, image-transport, camera-calibration-parsers, catkin, polled-camera }:
buildRosPackage {
  pname = "ros-kinetic-image-common";
  version = "1.11.13";

  src = fetchurl {
    url = https://github.com/ros-gbp/image_common-release/archive/release/kinetic/image_common/1.11.13-0.tar.gz;
    sha256 = "2d847bf4cd08c9c1ba3f7ec9708b6a50735668a321a47e0d0a26c02157e0896d";
  };

  propagatedBuildInputs = [ camera-calibration-parsers image-transport camera-info-manager polled-camera ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''Common code for working with images in ROS.'';
    #license = lib.licenses.BSD;
  };
}