{
  pkgs,
  specialArgs,
  lib,
  ...
}:
let
  inherit (specialArgs) username;
in
{
  warashi.services.muscat.enable = true;

  home = {
    packages = with pkgs; [
      terminal-notifier
    ];
  };
}
