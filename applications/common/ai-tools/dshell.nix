{
  config,
  inputs,
  pkgs,
  ...
}:
let
  merger = pkgs.callPackage ./merger { };
  dshell = pkgs.callPackage ./dshell { inherit merger; };
  defaultConfig = (pkgs.formats.json { }).generate "dshell-settings-default.json" {
    name = "Global Fallback Shell";
    image = "mcr.microsoft.com/devcontainers/base:ubuntu";
    remoteUser = "vscode";
  };
  overrideConfig = (pkgs.formats.json { }).generate "dshell-settings-override.json" {
    remoteEnv = {
      CLAUDE_CONFIG_DIR = "/home/vscode/.claude";
    };
    features = {
      # keep-sorted start block=yes
      "ghcr.io/devcontainers-extra/features/claude-code:1" = { };
      "ghcr.io/devcontainers/features/common-utils:2" = {
        "configureZshAsDefaultShell" = true;
      };
      "ghcr.io/devcontainers/features/docker-in-docker:2" = { };
      "ghcr.io/devcontainers/features/go:1" = { };
      "ghcr.io/rails/devcontainer/features/mysql-client:1" = { };
      # keep-sorted end
    };
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
    "dshell/override/devcontainer.json" = {
      source = overrideConfig;
    };
  };
}
