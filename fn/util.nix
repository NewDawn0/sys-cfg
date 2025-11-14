let
  importRec =
    base:
    let
      paths = with builtins; attrNames (readDir base);
      filtered = builtins.filter (x: x != "default.nix");
      toPath = x: base + "/${x}";
    in
    map (toPath) (filtered paths);
in
{
  inherit importRec;
}
