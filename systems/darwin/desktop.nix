{
  imports = [
    ../../applications/darwin
  ];

  security.pam.services.sudo_local = {
    reattach = true;
    touchIdAuth = true;
    watchIdAuth = true;
  };

  programs.warashi = {
    arto.enable = true;
  };

  services.warashi = {
    aerospace.enable = false;
    paneru.enable = true;
    sketchybar.enable = false;
    jankyborders.enable = true;
  };
}
