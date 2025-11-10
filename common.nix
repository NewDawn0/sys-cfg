{
  host,
  inputs,
  system,
}:
{
  inherit system;
  specialArgs = {
    inherit inputs;
    fn = import ./fn { inherit (inputs) nixpkgs; };
  };
  modules = [
    inputs.disko.nixosModules.disko
    inputs.nix-flatpak.nixosModules.nix-flatpak
    ./hosts/${host}
    ./identity
    ./shared
  ];
}
