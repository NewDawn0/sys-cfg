{
  services.fstrim.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  zramSwap.enable = true;
  boot = {
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "splash"
    ];
  };
}
