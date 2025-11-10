{
  fn,
  pkgs,
  ...
}: let
  users = ["root" "dawn"];
in {
  # Locale & Keymap
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "sg";
  time.timeZone = "Europe/Zurich";
  services.xserver.xkb = {
    layout = "ch";
    variant = "de_nodeadkeys";
  };
  # Users
  users.users = fn.util.mkUsers {
    inherit users;
    extraArgs = {
      shell = pkgs.zsh;
      extraGroups = ["networkmanager" "wheel"];
      hashedPassword = "$6$qZmB8JLWqy86gMdw$aciIbKbCygzoFcc1909fX47A9BCw7SL3MBpuNHSGO37.14ujd9nxCujtSYW0yAwfF/LXqMUXObr158Q5ZxPu2/";
      packages = import ./pkgs.nix {inherit pkgs;};
    };
  };
}
