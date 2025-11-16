{
  fn,
  lib,
  ...
}: {
  # System state version
  system.stateVersion = fn.util.getVersion lib.version;
  # SSH Setup
  programs.ssh.startAgent = true;
  services.openssh.enable = true;
}
