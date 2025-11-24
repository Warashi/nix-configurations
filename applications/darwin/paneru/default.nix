{
  config,
  pkgs,
  lib,
  specialArgs,
  ...
}:
with lib;
let
  inherit (specialArgs) username;
  cfg = config.services.warashi.paneru;
in
{
  options = with types; {
    services.warashi.paneru = {
      enable = mkEnableOption "warashi's AeroSpace configs";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username}.services.paneru = {
      enable = true;
      settings = {
        options = {
          focus_follows_mouse = true;
          preset_column_widths = [
            0.25
            0.33
            0.50
            0.66
            0.75
            1.00
          ];
          swipe_gesture_fingers = 4;
          animation_speed = 10000;
        };
        bindings = {
          window_focus_west = "ctrl + shift + alt - h";
          window_focus_east = "ctrl + shift + alt - l";
          window_focus_north = "ctrl + shift + alt - k";
          window_focus_south = "ctrl + shift + alt - j";
          window_swap_west = "cmd + ctrl + shift + alt - h";
          window_swap_east = "cmd + ctrl + shift + alt - l";
          window_center = "ctrl + shift + alt - c";
          window_resize = "ctrl + shift + alt - r";
          window_stack = "ctrl + shift + alt - [";
          window_unstack = "ctrl + alt + shift - ]";
          quit = "cmd + ctrl + shift + alt - q";
        };
      };
    };
  };
}
