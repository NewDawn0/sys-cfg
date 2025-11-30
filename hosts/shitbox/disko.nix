{
  fn,
  pkgs,
  ...
}:
let
  disks = {
    main = "/dev/nvme0n1";
    win = "/dev/nvme0n2";
  };
  mkSecret =
    {
      path,
      outPath ? path,
    }:
    let
      pkg = pkgs.runCommandNoCC "luks-secret" { } ''
        install -D ${path} $out/${outPath}
      '';
    in
    "${pkg}/${outPath}";
  mainKey = mkSecret {
    path = ../../secrets/luks-main.key;
    outPath = "luks-main.key";
  };
  passKey = mkSecret {
    path = ../../secrets/luks-pass.txt;
    outPath = "luks-pass.txt";
  };
in
with fn;
{
  boot.initrd.secrets."/luks-main.key" = mainKey;
  disko.devices.disk = {
    main = fs.mkDisk {
      disk = disks.main;
      partitions = {
        esp = fs.mkESP { };
        swap = fs.mkSwap { size = "32G"; };
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
    win = fs.mkDisk {
      disk = disks.win;
      partitions = {
        shared = fs.mkNTFS {
          size = "500G";
          name = "shared";
          zero = true;
        };
        windows = fs.mkNTFS {
          size = "500G";
          name = "windows";
          zero = true;
        };
      };
    };
  };
}
