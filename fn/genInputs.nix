# Automatically adding `nixpkgs.follows = "nixpkgs"` to sources.
{}
: {
  direct,
  sources,
}:
direct
// builtins.mapAttrs (
  _name: value:
    value
    // {
      inputs.nixpkgs.follows = "nixpkgs";
    }
)
sources
