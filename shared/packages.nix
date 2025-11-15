{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
    # Terminal & Multiplexer
    ghostty
    tmux
    # Git & GitHub
    delta
    gh
    git
    git-lfs
    pinentry-qt
    # Misc Tooling
    stow
    (mpv.override {
      scripts = with mpvScripts; [
        autosub
        inhibit-gnome
        modernz
        sponsorblock
      ];
    })
  ];
}
