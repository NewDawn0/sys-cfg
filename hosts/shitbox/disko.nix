{
  fn,
  pkgs,
  ...
}:
let
  disk-cfg = {
    dev1 = "/dev/nvme0n1";
    dev2 = "/dev/nvme1n1";
    luks = {
      main = "${pkgs.secrets}/secrets/luks/main.key";
      pass = "${pkgs.secrets}/secrets/luks/pass.txt";
    };
  };
in
with fn;
{
  boot.initrd.secrets."/luks-main.key" = disk-cfg.luks.main;
  disko.devices.disk = {
    main = fs.mkDisk {
      disk = disk-cfg.dev1;
      partitions = {
        esp = fs.mkESP { };
        swap = fs.mkSwap { size = "32G"; };
        root = fs.mkLuks {
          main = "/luks-main.key";
          inherit (disk-cfg.luks) pass;
          content = fs.mkBtrfs {
            subvolumes = {
              "@root" = fs.mkSubvol "/";
              "@home" = fs.mkSubvol "/home";
              "@etc" = fs.mkSubvol "/etc";
              "@nix" = fs.mkSubvol "/nix";
              "@tmp" = fs.mkSubvol "/tmp";
              "@var" = fs.mkSubvol "/var";
            };
          };
        };
      };
    };
    win = fs.mkDisk {
      disk = disk-cfg.dev2;
      partitions = {
        shared = fs.mkShared { size = "2T"; };
        windows = fs.mkWindows { size = "100%"; };
      };
    };
  };
}
