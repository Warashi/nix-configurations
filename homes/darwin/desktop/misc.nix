{
  config,
  pkgs,
  lib,
  specialArgs,
  ...
}:
let
  inherit (specialArgs) username;
in
{
  warashi.services.muscat.enable = true;

  home = {
    sessionVariables = {
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    packages = with pkgs; [
      terminal-notifier
    ];
  };
}
