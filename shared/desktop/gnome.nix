{pkgs, ...}: {
  services.xserver = {
    desktopManager.gnome.enable = true;
  };
  # Gnome config
  services.gnome = {
    sushi.enable = true;
    evolution-data-server.enable = true;
    gnome-online-accounts.enable = true;
    core-shell.enable = true;
    core-os-services.enable = true;
  };
  # Gnome packages
  environment = {
    systemPackages = with pkgs; [
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-control-center
      gnome-disk-utility
      gnome-font-viewer
      gnome-software
      gnome-system-monitor
      gnome-text-editor
      gnome-weather

      image-roll
      nautilus
    ];
    gnome.excludePackages = with pkgs; [
      cheese
      epiphany
      geany
      geary
      gnome-builder
      gnome-console
      gnome-music
      gnome-tour
      gnome-user-docs
      gnome-connections
      d-spy
      dconf-editor
      yelp
      devhelp
      totem
    ];
  };
}
