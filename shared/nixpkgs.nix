{
  lib,
  args,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "x86_64-linux";
    overlays = with args; [
      boot-club.overlays.default
    ];
  };
  nix = {
    gc.automatic = true;
    registry = {
      devShells.flake = args.devShells;
      unstable.flake = args.nixpkgs-unstable;
    };
    settings = {
      cores = 0;
      max-jobs = "auto";
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  # TODO: Readd on next nixos stable update
  # services.angrr = {
  #   enable = true;
  #   enableNixGcIntegration = true;
  #   period = "2weeks";
  # };
}
