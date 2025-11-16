{
  services.flatpak = {
    enable = true;
    packages = [
      {
        flatpakref = "https://releases.threema.ch/flatpak/threema-desktop/ch.threema.threema-desktop.flatpakref";
        sha256 = "sha256:0lghiiiphbkqgiprqirxifldvix0j4k04jh1z9f911shrzjgqq4s";
      }
      "eu.jumplink.Learn6502"
    ];
    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };
    overrides = {
      "org.threema.threema-desktop".Context = {
        filesystem = "host";
      };
    };
  };
}
