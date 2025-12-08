{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.services.warashi.sketchybar;
in
{
  options = with types; {
    services.warashi.sketchybar = {
      enable = mkEnableOption "warashi's aerospace configs";
    };
  };

  config = mkIf cfg.enable {
    services.sketchybar = {
      enable = true;
      config = pkgs.callPackage ./configs {
        callPackage = lib.callPackageWith (
          pkgs
          // {
            notch-height = pkgs.callPackage ./notch-height { };
          }
        );
      };
    };
  };
}
