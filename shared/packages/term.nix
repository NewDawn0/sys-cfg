{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Terminal & Multiplexer
    ghostty
    tmux
    # Shell
    eza
    fastfetch
    fzf
    gnupg
    jq
    ripgrep
    starship
    trash-cli
    uutils-coreutils-noprefix
    xdg-utils
    zoxide
  ];
}
