{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Devel
    direnv
    jq
    # neovim
    file
    nurl
    nvim-full
    ripgrep
    stow
    tmux
    # Shell
    ani-cli
    eza
    fastfetch
    fd
    fzf
    gitui
    starship
    trash-cli
    zoxide
  ];
}
