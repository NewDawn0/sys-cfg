{pkgs, ...}: {
  environment = {
    shells = [pkgs.zsh];
    variables.ZDOTDIR = "$HOME/.config/zsh";
  };
  programs.zsh.enable = true;
}
