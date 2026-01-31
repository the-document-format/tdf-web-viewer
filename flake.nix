{
  description = "The Document Format Web Viewer";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        treefmtconfig = inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true;
            biome.enable = true;
          };
        };
      in
      {
        packages = rec {
          default = web-viewer;
          web-viewer = pkgs.callPackage ./nix/build.nix { };
        };

        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nodejs
              pnpm
              biome
            ];
          };
        };

        formatter = treefmtconfig.config.build.wrapper;

        checks = {
          formatting = treefmtconfig.config.build.check self;
        };
      }
    );
}
