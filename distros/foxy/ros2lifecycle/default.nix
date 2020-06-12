
# Copyright 2020 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-copyright, ament-flake8, ament-pep257, ament-xmllint, lifecycle-msgs, pythonPackages, rclpy, ros-testing, ros2cli, ros2lifecycle-test-fixtures, ros2node, ros2service }:
buildRosPackage {
  pname = "ros-foxy-ros2lifecycle";
  version = "0.9.5-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ros2cli-release/archive/release/foxy/ros2lifecycle/0.9.5-1.tar.gz";
    name = "0.9.5-1.tar.gz";
    sha256 = "9c806e2029a31f334e5ffe8594d7d515ceb781c331c66b706f740f5839b2d170";
  };

  buildType = "ament_python";
  checkInputs = [ ament-copyright ament-flake8 ament-pep257 ament-xmllint pythonPackages.pytest ros-testing ros2lifecycle-test-fixtures ];
  propagatedBuildInputs = [ lifecycle-msgs rclpy ros2cli ros2node ros2service ];

  meta = {
    description = ''The lifecycle command for ROS 2 command line tools.'';
    license = with lib.licenses; [ asl20 ];
  };
}
