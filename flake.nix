{
  description = "Schrödinger - A flaky system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # System
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-utils = {
      url = "github:NewDawn0/nixUtils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };
    # UI
    boot-club = {
      url = "github:NewDawn0/boot-club";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Applications
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nvim-cfg = {
      url = "path:/home/dawn/GitHub/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    napps = {
      url = "path:/home/dawn/GitHub/apps";
      inputs.nix-utils.follows = "nix-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };
    secrets-mgr = {
      url = "path:/home/dawn/GitHub/secrets-mgr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    args@{
      nix-utils,
      ...
    }:
    let
      perSystem = nix-utils.lib.eachSystem { };
    in
    {
      checks = perSystem (
        pkgs: _: {
          deadnix = pkgs.runCommand "deadnix" {
            nativeBuildInputs = [ pkgs.deadnix ];
          } "deadnix --fail ${./.} && touch $out";
        }
      );
      formatter = perSystem (pkgs: _: pkgs.alejandra);
      nixosConfigurations =
        let
          mkModules = host: [
            args.disko.nixosModules.disko
            args.nix-flatpak.nixosModules.nix-flatpak
            ./hosts/${host}
            ./identity
            ./shared
          ];
          mkSpecialArgs = {
            inputs = args;
            fn = import ./fn { inherit (args) nixpkgs; };
          };
        in
        {
          schroedinger = args.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = mkModules "schroedinger";
            specialArgs = mkSpecialArgs;
          };
          shitbox = args.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = mkModules "shitbox";
            specialArgs = mkSpecialArgs;
          };
        };
    };
}
