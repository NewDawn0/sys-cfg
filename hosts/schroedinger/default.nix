{fn, ...}: {
  imports = fn.util.importRec ./.;
  networking.hostName = "schroedinger";
}
