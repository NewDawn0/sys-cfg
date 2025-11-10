{
  pkgs,
  lib,
  ...
}:
let
  zshc = pkgs.nd-apps.zsh.passthru;
in
{
  # BUG: Do not set environment.sessionVariables!
  # It will break PAM and therefore the system
  environment = {
    shells = [ pkgs.zsh ];
    systemPackages = zshc.packages;
  };
  programs = {
    zoxide.enableZshIntegration = true;
    direnv.enableZshIntegration = true;
    zsh = {
      enable = true;
      # Plugins
      autosuggestions.enable = true;
      enableBashCompletion = true;
      enableCompletion = true;
      enableLsColors = true;
      syntaxHighlighting.enable = true;
      # Options
      vteIntegration = true;
      histSize = 10000;
      promptInit = "";
      interactiveShellInit = lib.concatStringsSep "\n" (
        with zshc;
        [
          init
          envExports
        ]
      );
      setOptions = zshc.shopts;
      # Aliases
      shellAliases = zshc.aliases // {
        sudo = "doas";
      };
    };
  };
}
