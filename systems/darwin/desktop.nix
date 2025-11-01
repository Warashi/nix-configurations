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
    aerospace.enable = true;
    sketchybar.enable = true;
    jankyborders.enable = true;
  };
}
