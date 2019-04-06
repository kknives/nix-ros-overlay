
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, catkin-pip, catkin, pythonPackages }:
buildRosPackage {
  pname = "ros-kinetic-click";
  version = "6.2.0-r1";

  src = fetchurl {
    url = https://github.com/asmodehn/click-rosrelease/archive/release/kinetic/click/6.2.0-1.tar.gz;
    sha256 = "013f8c679a4570dd4795f91b8984f1ad66b6cfb594b285c8e5087a5a3cc57ef9";
  };

  checkInputs = [ pythonPackages.colorama ];
  nativeBuildInputs = [ catkin-pip catkin ];

  meta = {
    description = ''Python composable command line utility http://click.pocoo.org/'';
    #license = lib.licenses.BSD;
  };
}