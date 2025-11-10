{nixpkgs}: let
  lib = nixpkgs.lib;
  fn = {};
in
  # Unified fn namespace custom library functions
  fn
  // {
    fs = import ./fs.nix {inherit lib;};
    util = import ./util.nix {inherit lib;};
  }
