{...}: {
  # Sometimes it boots, sometimes it doesn't.
  # It's not a bug, it's quantum computing
  networking.hostName = "schroedinger";
  boot.loader.efi.canTouchEfiVariables = true;
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
  };
}
