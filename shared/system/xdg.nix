{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config = {
      hyprland.preferred = [
        "hyprland"
        "gtk"
      ];
    };
    wlr.enable = true;
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/html" = ["firefox.desktop"];
      "application/pdf" = "firefox.desktop";
    };
  };
}
