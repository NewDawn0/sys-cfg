{pkgs, ...}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = false;
    timeout = 10;

    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      copyKernels = true;
      useOSProber = true;
      memtest86.enable = true;
      theme = pkgs.grubThemes.arcade;
      extraEntries = ''
        menuentry "Shutdown" --class shutdown { halt; }
        menuentry "Reboot" --class reboot { reboot; }
        menuentry "Firmware Setup" --class  uefi { fwsetup; }
      '';
    };
  };
}
