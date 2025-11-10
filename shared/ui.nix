{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
  services.gnome = {
    core-apps.enable = true;
    core-developer-tools.enable = true;
    evolution-data-server.enable = true;
    games.enable = false;
    gnome-keyring.enable = true;
    gnome-online-accounts.enable = true;
  };
  environment = {
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
