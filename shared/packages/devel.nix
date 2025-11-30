{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Devel
    direnv
    jq
    nurl
    nvim-full
    ripgrep
    tldr
    typst
    # neovim
    ffmpeg
    file
    stow
    tmux
    # Shell
    ani-cli
    dipc
    eza
    fastfetch
    fd
    fzf
    gitui
    mktemp
    pay-respects
    starship
    trash-cli
    typos
    zoxide
  ];
}
