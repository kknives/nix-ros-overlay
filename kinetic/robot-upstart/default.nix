
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, roslint, catkin, daemontools, rosunit, roslaunch, xacro }:
buildRosPackage {
  pname = "ros-kinetic-robot-upstart";
  version = "0.3.0";

  src = fetchurl {
    url = https://github.com/clearpath-gbp/robot_upstart-release/archive/release/kinetic/robot_upstart/0.3.0-0.tar.gz;
    sha256 = "ec7dae737ea612be27888afd2836acdf4ce2f398afaeddf31a5d27acd687e5dd";
  };

  checkInputs = [ rosunit roslint ];
  propagatedBuildInputs = [ roslaunch daemontools xacro ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''The robot_upstart package provides scripts which may be used to install
    and uninstall Ubuntu Linux upstart jobs which launch groups of roslaunch files.'';
    #license = lib.licenses.BSD;
  };
}