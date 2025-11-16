{pkgs, ...}: {
  # Printing config
  services.printing = {
    enable = true;
    defaultShared = true;
    drivers = with pkgs; [
      # Driverless printing
      cups-filters
      ghostscript
      # HP
      hplipWithPlugin
      # Brother
      brgenml1cupswrapper
      brgenml1lpr
      brlaser
      # Epson
      epson-escpr
      # Universal
      gutenprint
    ];
  };
  # Scanner config
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.hplip];
  };
  # Printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    publish.enable = true;
    openFirewall = true;
  };
  # Printer network rules
  networking.firewall = {
    allowedTCPPorts = [631];
    allowedUDPPorts = [631];
  };
}
