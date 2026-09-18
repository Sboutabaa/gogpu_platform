{
  description = "golang  template";

  inputs.nixpkgs.url = "nixpkgs";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    flake-utils,
  }: (
    flake-utils.lib.eachDefaultSystem
    (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

      callPackage = pkgs.callPackage;
    in {
      devShells.default = callPackage ./shell.nix {
        inherit pkgs;
        inherit pkgs-unstable;
      };
    })
  );
}
