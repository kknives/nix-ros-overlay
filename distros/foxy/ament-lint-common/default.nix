
# Copyright 2020 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-copyright, ament-cmake-core, ament-cmake-cppcheck, ament-cmake-cpplint, ament-cmake-export-dependencies, ament-cmake-flake8, ament-cmake-lint-cmake, ament-cmake-pep257, ament-cmake-uncrustify, ament-cmake-xmllint }:
buildRosPackage {
  pname = "ros-foxy-ament-lint-common";
  version = "0.9.4-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ament_lint-release/archive/release/foxy/ament_lint_common/0.9.4-1.tar.gz";
    name = "0.9.4-1.tar.gz";
    sha256 = "75923c206098b0dc2139c82ba82fd141a2ea87a9c71cfb3b87b3f1079849335e";
  };

  buildType = "ament_cmake";
  propagatedBuildInputs = [ ament-cmake-copyright ament-cmake-core ament-cmake-cppcheck ament-cmake-cpplint ament-cmake-flake8 ament-cmake-lint-cmake ament-cmake-pep257 ament-cmake-uncrustify ament-cmake-xmllint ];
  nativeBuildInputs = [ ament-cmake-core ament-cmake-export-dependencies ];

  meta = {
    description = ''The list of commonly used linters in the ament buildsytem in CMake.'';
    license = with lib.licenses; [ asl20 ];
  };
}
