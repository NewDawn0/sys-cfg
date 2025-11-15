{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
