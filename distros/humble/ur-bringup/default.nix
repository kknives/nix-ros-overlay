
# Copyright 2022 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-python, controller-manager, force-torque-sensor-broadcaster, joint-state-broadcaster, joint-state-publisher, joint-trajectory-controller, launch, launch-ros, position-controllers, rclpy, robot-state-publisher, ros2-controllers-test-nodes, rviz2, ur-controllers, ur-description, urdf, velocity-controllers, xacro }:
buildRosPackage {
  pname = "ros-humble-ur-bringup";
  version = "2.2.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/Universal_Robots_ROS2_Driver-release/archive/release/humble/ur_bringup/2.2.1-1.tar.gz";
    name = "2.2.1-1.tar.gz";
    sha256 = "89cde969371cd97f49c2c7f2c5205a1cfbbd87486af8ff835daae57b9d87bbdc";
  };

  buildType = "ament_cmake";
  propagatedBuildInputs = [ controller-manager force-torque-sensor-broadcaster joint-state-broadcaster joint-state-publisher joint-trajectory-controller launch launch-ros position-controllers rclpy robot-state-publisher ros2-controllers-test-nodes rviz2 ur-controllers ur-description urdf velocity-controllers xacro ];
  nativeBuildInputs = [ ament-cmake ament-cmake-python ];

  meta = {
    description = ''Launch file and run-time configurations, e.g. controllers.'';
    license = with lib.licenses; [ bsd3 ];
  };
}