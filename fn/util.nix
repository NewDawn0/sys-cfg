{lib}: let
  getVersion = let
    full = lib.version;
    match = builtins.match "([0-9]+\.[0-9]+).*" full;
    version =
      if match == null
      then throw "Could not parse version from '${full}'"
      else builtins.head match;
  in
    version;

  importDir = dir:
    with builtins;
      map (f: dir + "/${f}")
      (filter (f: f != "default.nix") (attrNames (readDir dir)));

  mkHomes = {
    users ? ["root"],
    extraArgs ? {},
  }:
    lib.genAttrs users (user: let
      isRoot = user == "root";
    in
      {
        imports = [../hm];
        programs.home-manager.enable = true;
        home = {
          username = user;
          stateVersion = getVersion;
          enableNixpkgsReleaseCheck = false;
          homeDirectory =
            if isRoot
            then "/root"
            else "/home/${user}";
        };
      }
      // extraArgs);

  mkUsers = {
    users ? ["root"],
    extraArgs ? {},
  }:
    lib.genAttrs users (user: let
      isRoot = user == "root";
      attrs =
        lib.optionalAttrs (!isRoot)
        {
          description = user;
          isNormalUser = !isRoot;
        }
        // extraArgs;
    in
      attrs);
in {inherit getVersion importDir mkHomes mkUsers;}
