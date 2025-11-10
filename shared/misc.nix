{fn, ...}: {
  system.stateVersion = fn.util.getVersion;
  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [57621];
      allowedUDPPorts = [5353];
    };
  };
}
