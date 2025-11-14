{
  mkBtrfs =
    {
      subvolumes,
      extraArgs ? [ "-f" ],
    }:
    {
      type = "btrfs";
      inherit extraArgs subvolumes;
    };
  mkBoot =
    {
      name ? "boot",
      size ? "1M",
    }:
    {
      inherit name size;
      type = "EF02";
    };
  mkDisk =
    {
      disk,
      partitions,
      type ? "disk",
      partitionType ? "gpt",
    }:
    {
      inherit type;
      device = disk;
      content = {
        inherit partitions;
        type = partitionType;
      };
    };
  mkESP =
    {
      format ? "vfat",
      mountOptions ? [ "umask=0077" ],
      mountpoint ? "/boot",
      name ? "ESP",
      size ? "1G",
    }:
    {
      inherit name size;
      type = "EF00";
      content = {
        inherit format mountOptions mountpoint;
        type = "filesystem";
      };
    };
  mkLuks =
    {
      content,
      main ? "/luks-main.key",
      pass ? "/luks-pass.key",
      allowDiscards ? true,
      fallbackToPassword ? true,
      name ? "cryptroot",
      size ? "100%",
    }:
    {
      inherit size;
      content = {
        inherit content name;
        additionalKeyFiles = [ "${pass}" ];
        type = "luks";
        settings = {
          keyFile = main;
          inherit allowDiscards fallbackToPassword;
        };
      };
    };
  mkShared =
    {
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
    }:
    {
      inherit size name;
      content = {
        type = "filesystem";
        inherit format mountOptions mountpoint;
      };
    };
  mkSubvol = mountpoint: {
    inherit mountpoint;
    mountOptions = [
      "compress=zstd"
      "noatime"
    ];
  };
  mkSwap =
    {
      size,
      randomEncryption ? true,
      resumeDevice ? true,
    }:
    {
      inherit size;
      content = {
        inherit randomEncryption resumeDevice;
        type = "swap";
      };
    };
  mkWindows =
    {
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
    }:
    {
      inherit size;
      name = "windows";
      content = {
        type = "filesystem";
        inherit format mountOptions mountpoint;
      };
    };
}
