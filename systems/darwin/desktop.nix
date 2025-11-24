{
  imports = [
    ../../applications/darwin
  ];

  security.pam.services.sudo_local = {
    reattach = true;
    touchIdAuth = true;
    watchIdAuth = true;
  };

  services.warashi = {
    aerospace.enable = false;
    sketchybar.enable = false;
    jankyborders.enable = true;
  };
}
