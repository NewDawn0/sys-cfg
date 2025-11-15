{
  fn,
  lib,
  ...
}: let
  extraGroups = [
    "networkmanager"
    "wheel"
  ];
  hashedPassword = "$6$qZmB8JLWqy86gMdw$aciIbKbCygzoFcc1909fX47A9BCw7SL3MBpuNHSGO37.14ujd9nxCujtSYW0yAwfF/LXqMUXObr158Q5ZxPu2/";
in {
  system.stateVersion = fn.util.getVersion lib.version;
  users.users = {
    dawn = {
      inherit extraGroups hashedPassword;
      isNormalUser = true;
    };
    root = {
      inherit extraGroups hashedPassword;
      isNormalUser = false;
    };
  };
}
