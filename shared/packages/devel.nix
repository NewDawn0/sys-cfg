{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Terminal & Multiplexer
    tmux
    # Devel
    jq
    neovim
    nurl
    ripgrep
    stow
    trash-cli
    # Shell
    ani-cli
    direnv
    eza
    fastfetch
    fzf
    starship
    zoxide
  ];
}
