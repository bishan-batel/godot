{ pkgs ? import <nixpkgs> { } }: 
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [ pkg-config autoPatchelfHook ];
  runtimeDependencies = with pkgs; [
    libGL
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXi
    xorg.libXrandr
  ];
  buildInputs = with pkgs; [ scons ninja ];
}

