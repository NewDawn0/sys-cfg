{
  description = "NewDawn0's system configurations'";

  inputs = {
    # Nix & Package sources
    nixpkgs.url = "github:nixos/nixpkgs?ref=25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flatpak.url = "github:gmodena/nix-flatpak";
    utils = {
      url = "github:NewDawn0/nixUtils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Themes
    boot-club = {
      url = "github:NewDawn0/boot-club";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    # Quick dev shells per lang
    devShells = {
      url = "github:NewDawn0/devShells.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    # Secrets mgmt
  };
  outputs = args @ {utils, ...}: {
    checks = utils.lib.eachSystem {} (
      p:
        with p; {
          deadnix = pkgs.runCommand "deadnix" {
            nativeBuildInputs = [pkgs.deadnix];
          } "deadnix --fail ${./.} && touch $out";
        }
    );
    formatter = utils.lib.eachSystem {} (p: p.pkgs.alejandra);
    nixosConfigurations = {
      schroedinger = args.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit args;
          fn = import ./fn {};
        };
        modules = [
          args.disko.nixosModules.disko
          args.flatpak.nixosModules.nix-flatpak
          ./hosts/schroedinger
          ./shared
        ];
      };
    };
  };
}
