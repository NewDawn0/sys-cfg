{pkgs, ...}: {
  boot = {
    loader = {
      timeout = 10;
      # TODO: Change to grub
      systemd-boot.enable = false;
      # efi.sysMountPoint = "/boot/EFI";
      grub = {
        enable = true;
        copyKernels = true;
        efiSupport = true;
        device = "nodev";
        memtest86.enable = true;
        theme = pkgs.grubThemes.arcade;
        # theme = pkgs.grubThemes.minegrub;
        useOSProber = true;
        extraEntries = ''
          menuentry "Shutdown" {
            halt
          }
          menuentry "Reboot" {
            reboot
          }
        '';
      };
    };
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "sdhci_pci" "thunderbolt" "usb_storage"];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd" "kvm-intel"];
    extraModulePackages = [];
  };
}
