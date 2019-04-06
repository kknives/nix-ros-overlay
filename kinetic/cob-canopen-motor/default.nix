
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, cob-generic-can, catkin, cob-utilities, roscpp }:
buildRosPackage {
  pname = "ros-kinetic-cob-canopen-motor";
  version = "0.6.13";

  src = fetchurl {
    url = https://github.com/ipa320/cob_driver-release/archive/release/kinetic/cob_canopen_motor/0.6.13-0.tar.gz;
    sha256 = "a33b97dabed4b6b2b3ffabcdf262d11833d453c9beb8d4959a9bfd7981347b9e";
  };

  propagatedBuildInputs = [ cob-generic-can roscpp cob-utilities ];
  nativeBuildInputs = [ cob-generic-can catkin roscpp cob-utilities ];

  meta = {
    description = ''The package cob_canopen_motor implements a controller-drive component which is connected to a can-bus and works with a canopen-interface. &quot;CanDriveItf&quot; provides a - more or less - generic interface to the controller-drive components. &quot;CanDrvie...&quot; then implements a specific setup, e.g. an ELMO Harmonica Controller in case of the &quot;CanDriveHarmonica&quot;.'';
    #license = lib.licenses.Apache 2.0;
  };
}