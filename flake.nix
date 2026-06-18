{
  description = "Nix flake to build the Godot Engine from source";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Define build and runtime dependencies
        buildDeps = with pkgs; [
          scons
          pkg-config
          gcc
        ];

        libDeps = with pkgs; [
          alsa-lib
          dbus
          fontconfig
          libX11
          libXcursor
          libXext
          libXinerama
          libXrandr
          libXrender
          libXi
          libXfixes
          libglvnd
          libxkbcommon
          openssl
          # speechd
          udev
          vulkan-loader
          wayland
        ];
      in
      {
        # Development shell providing the build environment
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = buildDeps;
          buildInputs = libDeps;

          # Ensure compiler/linker can find graphics and vulkan drivers at runtime
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libDeps;
        };

      });
}
