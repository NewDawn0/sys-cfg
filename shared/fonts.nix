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
        _0xproto
        _3270
        adwaita-mono
        anonymice
        code-new-roman
        commit-mono
        droid-sans-mono
        fira-code
        fira-mono
        hack
        iosevka-term
        jetbrains-mono
        noto
        roboto-mono
      ]);
  };
}
