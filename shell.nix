{
  pkgs,
  pkgs-unstable,
}: let
  # TODO: add a darwin flag that deactivates all linux and nixos code
  NIX_LD_LIBRARY_PATH = with pkgs;
    lib.makeLibraryPath [
      libX11
      libXext
      libXrandr
      libXinerama
      libXcursor
      libxi

      wayland
      wayland-protocols
      libxkbcommon
    ];
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      # gnumake
      # gcc
      # pkg-config

      libX11
      libXext
      libXrandr
      libXinerama
      libXcursor
      libxi

      wayland
      wayland-protocols
      libxkbcommon
    ];

    packages = with pkgs; [
      go_1_26
    ];
    shellHook = ''
            export NIX_LD_LIBRARY_PATH='${NIX_LD_LIBRARY_PATH}'${"\${NIX_LD_LIBRARY_PATH:+':'}$NIX_LD_LIBRARY_PATH"}
      # Not ideal but needed on nixos due to ffi.Dlopen
            export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
            export GOPATH="$PWD/.go_bin"
    '';
  }
