{pkgs, ...}: {
  environment = {
    shells = [pkgs.zsh];
    variables.ZDOTDIR = "$HOME/.config/zsh";
  };
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}
