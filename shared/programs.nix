{pkgs, ...}: {
  programs = {
    hyprland.enable = true;
    gnupg.agent.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [obs-tuna wlrobs];
    };
  };
}
