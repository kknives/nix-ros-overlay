
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, roseus, catkin, pkg-config, assimp-devel, euslisp }:
buildRosPackage {
  pname = "ros-kinetic-eus-assimp";
  version = "0.4.2";

  src = fetchurl {
    url = https://github.com/tork-a/jsk_model_tools-release/archive/release/kinetic/eus_assimp/0.4.2-0.tar.gz;
    sha256 = "2a1ab35081290825e37022a99c6e8f04460e76aef4af6cea16befa0a94dae2d8";
  };

  propagatedBuildInputs = [ roseus assimp-devel ];
  nativeBuildInputs = [ catkin euslisp pkg-config assimp-devel ];

  meta = {
    description = ''eus_assimp'';
    #license = lib.licenses.BSD;
  };
}