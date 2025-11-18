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
    # Utilities
    # > Grub 2 themes
    boot-club = {
      url = "github:NewDawn0/boot-club";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    # > Quick development environment per language
    devShells = {
      url = "github:NewDawn0/devShells.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    # > Disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # > @TEMP: Configured Neovim
    nvim-configured = {
      url = "path:/home/dawn/GitHub/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # > Secrets management
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
