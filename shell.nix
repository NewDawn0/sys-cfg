{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [gnumake ripgrep eza];
  shellHook = ''
    alias nix-fu="nix --extra-experimental-features 'nix-command flakes' flake update"
    alias nix-bu="nix --extra-experimental-features 'nix-command flakes' build"
  '';
}
