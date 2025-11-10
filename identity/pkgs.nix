{ pkgs }:
let
  n = pkgs.nd-apps;
in
with pkgs;
[
  curl
  evolution
  eza
  firefox
  ghostty
  keepassxc
  nurl
  nvim-full
  ripgrep
  spotify
  warp
  wget
  whatsie
  wl-clipboard
  # TODO: add config
  jetbrains.idea-community
  # JAVA for intellij
  jdk21_headless
  obsidian
  onlyoffice-bin
  (discord.override { withVencord = true; })
  localsend
  # TODO: Publish app repo
  # Custom configured packages
  n.git
  n.tmux
  n.mpv
]
