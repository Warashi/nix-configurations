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
  cfg = config.programs.warashi.arto;
in
{
  options = with types; {
    programs.warashi.arto = {
      enable = mkEnableOption "warashi's Arto configs";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username}.home.packages = [
      inputs.arto.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
