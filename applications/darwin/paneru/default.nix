{
  inputs,
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
  info-plist = pkgs.writeText "Info.plist" (
    lib.generators.toPlist { escape = true; } {
      CFBundleName = "Paneru";
      CFBundleDisplayName = "Paneru";
      CFBundleIdentifier = "dev.warashi.Paneru";
      CFBundleExecutable = "Paneru";
      CFBundleVersion = "0.1.0";
      CFBundleShortVersionString = "0.1.0";
      CFBundlePackageType = "APPL";
      CFBundleInfoDictionaryVersion = "6.0";
    }
  );
  package = pkgs.runCommand "Paneru-app" { } ''
    set -euo pipefail
    app="$out/Applications/Paneru.app"
    mkdir -p "$app/Contents/MacOS" "$app/Contents/Resources"

    install -m444 ${info-plist} "$app/Contents/Info.plist"
    install -m555 "${
      inputs.paneru.packages.${pkgs.stdenv.hostPlatform.system}.default
    }/bin/paneru" "$app/Contents/MacOS/Paneru"

    mkdir -p $out/bin
    ln -s "../Applications/Paneru.app/Contents/MacOS/Paneru" "$out/bin/paneru"
  '';
in
{
  options = with types; {
    services.warashi.paneru = {
      enable = mkEnableOption "warashi's paneru configs";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      launchd.agents.paneru.config = {
        EnvironmentVariables = {
          XDG_CONFIG_HOME = config.home-manager.users.${username}.xdg.configHome;
        };
        Program = lib.mkForce (package + /Applications/Paneru.app/Contents/MacOS/Paneru);

      };
      services.paneru = {
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
  };
}
