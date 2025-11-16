{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/html" = ["firefox.desktop"];
      "application/pdf" = "firefox.desktop";
    };
  };
}
