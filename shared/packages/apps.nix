{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Apps
    firefox
    ghostty
    gnomecast
    jetbrains.idea-community
    keepassxc
    localsend
    pavucontrol
    spotify
    thunderbird
    # vial
    wasistlos
    zed-editor
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
    # jdkVersions : 8,11,13,23,24,27
    package = pkgs.jdk24;
  };
}
