{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Apps
    firefox
    ghostty
    gnomecast
    jetbrains.idea-community
    keepassxc
    localsend
    spotify
    thunderbird
    wasistlos
    # Configured
    (discord.override {
      withVencord = true;
      withOpenASAR = true;
    })
    (mpv.override {
      scripts = with mpvScripts; [
        autosub
        inhibit-gnome
        modernz
        sponsorblock
      ];
    })
  ];
  # Dependencies
  programs.java = {
    enable = true;
    package = pkgs.jdk24;
  };
}
