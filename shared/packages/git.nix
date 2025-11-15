{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    delta
    gh
    git
    git-lfs
    pinentry-qt
  ];
}
