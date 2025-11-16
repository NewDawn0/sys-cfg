{
  fn,
  pkgs,
  ...
}: let
  disk = "/dev/nvme0n1";
  mkSecret = {
    path,
    outPath ? path,
  }: let
    pkg = pkgs.runCommandNoCC "luks-secret" {} ''
      install -D ${path} $out/${outPath}
    '';
  in "${pkg}/${outPath}";
  mainKey = mkSecret {
    path = ../../secrets/luks-main.key;
    outPath = "luks-main.key";
  };
  passKey = mkSecret {
    path = ../../secrets/luks-pass.txt;
    outPath = "luks-pass.txt";
  };
in
  with fn; {
    boot.initrd.secrets."/luks-main.key" = mainKey;
    disko.devices.disk.main = fs.mkDisk {
      inherit disk;
      partitions = {
        esp = fs.mkESP {};
        swap = fs.mkSwap {size = "32G";};
        shared = fs.mkNTFS {
          size = "500G";
          name = "shared";
          zeroPartition = true;
        };
        windows = fs.mkNTFS {
          size = "500G";
          name = "windows";
          formatPartition = false;
        };
        root = fs.mkLuks {
          inherit mainKey passKey;
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
