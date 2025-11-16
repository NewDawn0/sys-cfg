{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig.enable = true;
    packages =
      (with pkgs; [
        corefonts
        font-awesome
        google-fonts
        minecraftia
        noto-fonts
        noto-fonts-color-emoji
        open-fonts
        open-sans
        source-code-pro
      ])
      ++ (with pkgs.nerd-fonts; [
        commit-mono
        droid-sans-mono
        fira-code
        fira-mono
        iosevka-term
        jetbrains-mono
        zed-mono
      ]);
  };
}
