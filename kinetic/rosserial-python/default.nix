
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, catkin, pythonPackages, rosserial-msgs, rospy, diagnostic-msgs }:
buildRosPackage {
  pname = "ros-kinetic-rosserial-python";
  version = "0.7.7";

  src = fetchurl {
    url = https://github.com/ros-gbp/rosserial-release/archive/release/kinetic/rosserial_python/0.7.7-0.tar.gz;
    sha256 = "f05a2b8500926c6066f925e87d71d94d5b4951a94399dc1015e97ef85e5130ce";
  };

  propagatedBuildInputs = [ diagnostic-msgs pythonPackages.pyserial rosserial-msgs rospy ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''A Python-based implementation of the rosserial protocol.'';
    #license = lib.licenses.BSD;
  };
}