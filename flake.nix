{
  description = "NewDawn0's system configurations'";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=25.05";
    utils = {
      url = "github:NewDawn0/nixUtils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # System
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    boot-club = {
      url = "github:NewDawn0/boot-club";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    devShells = {
      url = "github:NewDawn0/devShells.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
  };
  outputs =
    args@{
      utils,
      ...
    }:
    {
      checks = utils.lib.eachSystem { } (
        p: with p; {
          deadnix = pkgs.runCommand "deadnix" {
            nativeBuildInputs = [ pkgs.deadnix ];
          } "deadnix --fail ${./.} && touch $out";
        }
      );
      formatter = utils.lib.eachSystem { } (p: p.pkgs.alejandra);
      nixosConfigurations = {
        schroedinger = args.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit args;
            fn = import ./fn { };
          };
          modules = [
            args.disko.nixosModules.disko
            ./mod.nix
            ./hosts/schroedinger
            ./shared
          ];
        };
      };
    };
}
