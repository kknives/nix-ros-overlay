{ distro, python }:

self: super: with self.lib; let

  applyOverlays = self: super: overlays: let
    curSuper = applyOverlays self super (init overlays);
  in if length overlays == 0 then super
     else curSuper // (last overlays) self curSuper;

  mkOverlay = overlays: let
    self = applyOverlays self {} overlays;
  in self;

  base = rosSelf: rosSuper: {
    callPackage = self.newScope rosSelf;

    buildRosPackage = rosSelf.callPackage ./build-ros-package { };

    buildEnv = rosSelf.callPackage ./build-env {
      inherit (self) buildEnv;
    };

    inherit python;
    pythonPackages = rosSelf.python.pkgs;

    boost = self.boost.override {
      python = rosSelf.python;
      enablePython = true;
    };
  };

  overrides = rosSelf: rosSuper: let
    patchBoostPython = let
      pythonVersion = rosSelf.python.sourceVersion;
      pythonLib = "python${pythonVersion.major}${pythonVersion.minor}";
    in ''
      sed -Ei CMakeLists.txt \
        -e 's/(Boost [^)]*)python[^ )]*([ )])/\1${pythonLib}\2/'
    '';
  in {
    # ROS package overrides/fixups

    actionlib = rosSuper.actionlib.overrideDerivation ({
      patches ? [], ...
    }: {
      patches = patches ++ [
        (self.fetchpatch {
          url = https://github.com/ros/actionlib/commit/677e952fcbfe49e6e4c5b835357f88740f49c6ff.patch;
          sha256 = "0825w6r5kzz9y7syrrn6q1v0fjrd8qhn11rq2n4kc064702r8jf7";
        })
      ];
    });

    camera-calibration-parsers = rosSuper.camera-calibration-parsers.overrideDerivation ({
      postPatch ? "", ...
    }: {
      postPatch = postPatch + patchBoostPython;
    });

    catkin = rosSuper.catkin.overrideDerivation ({
      postPatch ? "", ...
    }: {
      postPatch = postPatch + ''
        patchShebangs cmake
        substituteInPlace cmake/templates/python_distutils_install.sh.in \
          --replace /usr/bin/env "${self.coreutils}/bin/env"
      '';
      setupHook = self.callPackage ./catkin-setup-hook { } distro;
    });

    cv-bridge = rosSuper.cv-bridge.overrideDerivation ({
      postPatch ? "",
      propagatedBuildInputs ? [], ...
    }: {
      postPatch = postPatch + patchBoostPython;
      propagatedBuildInputs = propagatedBuildInputs ++ [ rosSelf.pythonPackages.opencv3 ];
    });

    dynamic-reconfigure = rosSuper.dynamic-reconfigure.overrideDerivation ({
      postPatch ? "", ...
    }: {
      postPatch = postPatch + ''
        substituteInPlace cmake/setup_custom_pythonpath.sh.in \
          --replace '#!/usr/bin/env sh' '#!${self.stdenv.shell}'
      '';
    });

    map-server = rosSuper.map-server.overrideDerivation ({
      nativeBuildInputs ? [], ...
    }: {
      nativeBuildInputs = nativeBuildInputs ++ [ self.pkgconfig ];
    });

    python-qt-binding = rosSuper.python-qt-binding.overrideDerivation ({
      postPatch ? "", ...
    }: {
      postPatch = ''
        sed -e "s#'-I', sip_dir,#'-I', '${rosSelf.pythonPackages.pyqt5}/share/sip/PyQt5',#" \
            -e "s#qtconfig\['QT_INSTALL_HEADERS'\]#'${self.qt5.qtbase.dev}/include'#g" \
            -i cmake/sip_configure.py
      '' + postPatch;
    });

    qt-gui-cpp = rosSuper.qt-gui-cpp.overrideDerivation ({
      nativeBuildInputs ? [], ...
    }: {
      nativeBuildInputs = nativeBuildInputs ++ [ rosSelf.pythonPackages.sip ];

      # Prevent /build RPATH references
      preFixup = "rm -r devel/lib";
    });

    rqt-gui = rosSuper.rqt-gui.overrideDerivation ({
      nativeBuildInputs ? [],
      postFixup ? "", ...
    }: {
      nativeBuildInputs = nativeBuildInputs ++ [ self.makeWrapper ];

      postFixup = ''
        wrapProgram $out/bin/rqt \
          --set QT_PLUGIN_PATH "${self.qt5.qtbase.bin}/${self.qt5.qtbase.qtPluginPrefix}"
      '' + postFixup;
    });

    urdf = rosSuper.urdf.overrideDerivation ({
      postPatch ? "", ...
    }: {
      postPatch = postPatch + patchBoostPython;
    });
  };
in mkOverlay [
  base
  (import (./. + "/${distro}/generated.nix"))
  overrides
  (import (./. + "/${distro}/overrides.nix") self)
]