{
  boot.initrd = {
    compressor = "zstd";
    compressorArgs = ["-19"];
    includeDefaultModules = false;
    availableKernelModules = [
      # Storage
      "ahci" # SATA AHCI support (HDDs, SATA SSDs)
      "nvme" # NVMe SSDs
      "thunderbolt"
      "uas" # USB Attached SCSI (modern USB SSDs)
      "usb_storage" # USB drives
      # Input
      "usbhid" # USB HID support
      "xhci_pci" # USB 3.0 controller
      # Security
      "aesni_intel" # AES Hardware Acceleration
      "cryptd" # Async cpu crypto
      "dm_crypt" # Luks encryption
      "sha1_ssse3" # Fast SHA1
      "sha256_ssse3" # Fast SHA256
      "sha512_ssse3" # Fast SHA512
      # File-systems
      "btrfs"
      "vfat"
    ];
    # Stop slow units from booting
    systemd.suppressedUnits = [
      "systemd-machine-id-commit.service"
    ];
  };
}
