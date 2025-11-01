{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.services.warashi.jankyborders;
in
{
  options = with types; {
    services.warashi.jankyborders = {
      enable = mkEnableOption "warashi's JankyBorders configs";
    };
  };

  config = mkIf cfg.enable {
    services.jankyborders = {
      enable = true;
      active_color = "0xFF00FF00";
      inactive_color = "0xFFFFFFFF";
      style = "uniform";
    };
  };
}
