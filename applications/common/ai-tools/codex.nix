{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  merger = pkgs.callPackage ./merger { };
  config-overrides = (pkgs.formats.toml { }).generate "codex-config-overrides.toml" {
  };
in
{
  home = {
    file = {
      ".codex/AGENTS.md".source = ./AGENTS.md;
    };
    activation = {
      warashi-codex-config-merger = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ -f ${config.home.homeDirectory}/.codex/config.toml ]; then
          run cp ${config.home.homeDirectory}/.codex/config.toml ${config.home.homeDirectory}/.codex/config.backup.toml
          if [ -f ${config.home.homeDirectory}/.codex/config.local.toml ]; then
            run ${lib.getExe merger} ${config.home.homeDirectory}/.codex/config.toml ${config.home.homeDirectory}/.codex/config.backup.toml ${config-overrides} ${config.home.homeDirectory}/.codex/config.local.toml
          else
            run ${lib.getExe merger} ${config.home.homeDirectory}/.codex/config.toml ${config.home.homeDirectory}/.codex/config.backup.toml ${config-overrides}
          fi
        fi
      '';
    };
  };
}
