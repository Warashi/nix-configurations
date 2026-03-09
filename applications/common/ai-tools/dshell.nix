{
  config,
  inputs,
  pkgs,
  lib,
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
      TERM = "\${localEnv:TERM}";
      COLORTERM = "\${localEnv:COLORTERM}";
    };
    features = {
      # keep-sorted start block=yes
      "ghcr.io/devcontainers/features/common-utils:2" = {
        "configureZshAsDefaultShell" = true;
      };
      "ghcr.io/devcontainers/features/docker-in-docker:2" = { };
      "ghcr.io/devcontainers/features/go:1" = { };
      "ghcr.io/devcontainers/features/nix:1" = {
        extraNixConfig = ''
          experimental-features = nix-command flakes
        '';
        packages = lib.strings.concatStringsSep "," [
          "gojq"
        ];
      };
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
