{
  # Parse the current version from a full version string
  # @param  str       full            - Full version string from lib.version:
  # @return str       parsed          - Parsed version
  getVersion = full: let
    match = builtins.match "([0-9]+\.[0-9]+).*" full;
  in
    if match == [] || match == null
    then throw "Unable to parse version from ${full}"
    else builtins.head match;

  # Import all items in a directory
  # @param  path      base            - Base path to import from
  # @return [path]    paths           - List of paths
  importRec = base: let
    paths = with builtins; attrNames (readDir base);
    filtered = builtins.filter (x: x != "default.nix");
    toPath = x: base + "/${x}";
  in
    map toPath (filtered paths);
}
