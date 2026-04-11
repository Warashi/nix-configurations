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
    arto.enable = false;
  };

  services.warashi = {
    aerospace.enable = true;
    paneru.enable = false;
    sketchybar.enable = true;
    jankyborders.enable = true;
  };
}
