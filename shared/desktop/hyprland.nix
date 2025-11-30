{ pkgs, unstable, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [
    unstable.hyprpanel
    apple-cursor
    brightnessctl
    hyprland-qtutils
    hyprlock
    networkmanagerapplet
    nwg-look
    playerctl
    rose-pine-cursor
    swww
    udiskie
    wofi
  ];
}
