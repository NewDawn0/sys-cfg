{
  fn,
  pkgs,
  ...
}:
let
  disk-cfg = {
    dev1 = "/dev/nvme0n1";
    luks = {
      # main = "${pkgs.secrets}/secrets/luks/main.key";
      # pass = "${pkgs.secrets}/secrets/luks/pass.txt";
      main = "/secrets/luks/main.key";
      pass = "/secrets/luks/pass.txt";
    };
  };
in
with fn;
{
  boot.initrd.secrets."/luks-main.key" = disk-cfg.luks.main;
  disko.devices.disk.main = fs.mkDisk {
    disk = disk-cfg.dev1;
    partitions = {
      esp = fs.mkESP { };
      swap = fs.mkSwap { size = "32G"; };
      shared = fs.mkShared { size = "400G"; };
      windows = fs.mkWindows { size = "600G"; };
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
}
