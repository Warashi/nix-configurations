{
  config,
  inputs,
  pkgs,
  ...
}:
let
  dshell = pkgs.callPackage ./dshell { };
  defaultConfig = (pkgs.formats.json { }).generate "dshell-settings-default.json" {
    name = "Global Fallback Shell";
    image = "mcr.microsoft.com/devcontainers/base:ubuntu";
    features = {
      "ghcr.io/devcontainers/features/common-utils:2" = {
        "configureZshAsDefaultShell" = true;
      };
    };
    "remoteUser" = "vscode";
  };
in
{
  home = {
    packages = [
      dshell
    ];
  };
  xdg.configFile = {
    "dshell/default/devcontainer.json" = {
      source = defaultConfig;
    };
  };
}
