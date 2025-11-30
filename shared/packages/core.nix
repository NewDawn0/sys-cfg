{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # System
    curl
    gnupg
    killall
    ncdu
    uutils-coreutils-noprefix
    wget
    wl-clipboard
    xdg-utils
    # Git
    delta
    gh
    git
    git-lfs
    pinentry-qt
  ];
}
