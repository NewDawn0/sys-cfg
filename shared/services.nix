{pkgs, ...}: {
  services = {
    dbus.enable = true;
    udev = {
      enable = true;
      packages = with pkgs; [libwacom];
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-browsed
        cups-filters
        gutenprint
        hplip
        splix
      ];
    };
    xserver.desktopManager.gnome.enable = true;
    xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    openssh.enable = true;
  };
  programs.ssh.startAgent = true;
}
