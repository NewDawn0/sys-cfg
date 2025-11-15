{
  # Create a btrfs partition
  # @param  attrs     subvolumes          - Subvolumes
  # @param  [str]?    extraArgs           - Extra arguments
  mkBtrfs = {
    subvolumes,
    extraArgs ? ["-f"],
  }: {
    type = "btrfs";
    inherit extraArgs subvolumes;
  };

  # Create a boot partition
  # @param  str?      name                - Name of the partition
  # @param  str?      size                - Size of the partition
  mkBoot = {
    name ? "boot",
    size ? "1M",
  }: {
    inherit name size;
    type = "EF02";
  };

  # Create a disko disk
  # @param  str       content             - Disk path
  # @param  attrs     partitions          - Partitions
  # @param  str?      type                - Type of the disk
  # @param  str?      partitionType       - Type of the partitions
  # @return attrs                         - Disko disk
  mkDisk = {
    disk,
    partitions,
    type ? "disk",
    partitionType ? "gpt",
  }: {
    inherit type;
    device = disk;
    content = {
      inherit partitions;
      type = partitionType;
    };
  };

  # Create an ESP partition
  # @param  str       content             - Inner partition
  # @param  str?      format              - Format of the partition
  # @param  [str]?    mountOptions        - Mount options
  # @param  str?      mountpoint          - Mountpoint
  # @param  str?      name                - Name of the partition
  # @param  str?      size                - Size of the partition
  mkESP = {
    format ? "vfat",
    mountOptions ? ["umask=0077"],
    mountpoint ? "/boot",
    name ? "ESP",
    size ? "1G",
  }: {
    inherit name size;
    type = "EF00";
    content = {
      inherit format mountOptions mountpoint;
      type = "filesystem";
    };
  };

  # Create a luks encrypted partition
  # @param  attrs     content             - Inner partition
  # @param  str       mainKey             - Main key file path
  # @param  str       passKey             - Passphrase key file path
  # @param  bool?     allowDiscards       - Whether to allow discards
  # @param  bool?     fallbackToPassword  - Whether to fallback to password
  # @param  str?      name                - Name of the partition
  # @param  str?      size                - Size of the partition
  # @return attrs                         - Partition
  mkLuks = {
    content,
    mainKey,
    passKey,
    allowDiscards ? true,
    fallbackToPassword ? true,
    name ? "cryptroot",
    size ? "100%",
  }: {
    inherit size;
    content = {
      inherit content name;
      additionalKeyFiles = ["${passKey}"];
      type = "luks";
      settings = {
        keyFile = mainKey;
        inherit allowDiscards fallbackToPassword;
      };
    };
  };

  # Create a shared NTFS partition
  # @param  str       size                - Size of the partition
  # @param  str?      name                - Name of the partition
  # @param  str?      format              - Format of the partition
  # @param  str?      mountpoint          - Mountpoint
  # @param  [str]?    mountOptions        - Mount options
  # @return attrs                         - Partition
  mkShared = {
    size,
    name ? "shared",
    format ? "ntfs",
    mountpoint ? "/shared",
    mountOptions ? [
      "utf8"
      "gid=100"
      "uid=1000"
      "dmask=0022"
      "fmask=0133"
      "windows_names"
      "nofail"
      "x-systemd.device-timeout=5s"
    ],
  }: {
    inherit size name;
    content = {
      type = "filesystem";
      inherit format mountOptions mountpoint;
    };
  };

  # Create a btrfs subvolume at a given mountpoint
  # @param  str       mountpoint          - Mountpoint
  # @return attrs                         - Subvolume
  mkSubvol = mountpoint: {
    inherit mountpoint;
    mountOptions = [
      "compress=zstd"
      "noatime"
    ];
  };

  # Create a swap partition
  # @param  str       size                - Size of the partition
  # @param  bool?     randomEncryption    - Whether to use random encryption
  # @param  bool?     resumeDevice        - Whether to resume device
  # @return attrs                         - Partition
  mkSwap = {
    size,
    randomEncryption ? true,
    resumeDevice ? true,
  }: {
    inherit size;
    content = {
      inherit randomEncryption resumeDevice;
      type = "swap";
    };
  };

  # Create a Windows partition
  # @param  str       size                - Size of the partition
  # @param  str?      format              - Format of the partition
  # @param  str?      mountpoint          - Mountpoint
  # @param  [str]?    mountOptions        - Mount options
  # @return attrs                         - Partition
  mkWindows = {
    size,
    format ? "ntfs",
    mountpoint ? "/windows",
    mountOptions ? [
      "ro"
      "utf8"
      "gid=100"
      "uid=1000"
      "dmask=0022"
      "fmask=0133"
      "windows_names"
      "nofail"
      "x-systemd.device-timeout=5s"
    ],
  }: {
    inherit size;
    name = "windows";
    content = {
      type = "filesystem";
      inherit format mountOptions mountpoint;
    };
  };
}
