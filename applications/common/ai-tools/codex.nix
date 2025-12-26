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
    mcp_servers = {
      git-mile = {
        command = "git";
        args = [
          "mile"
          "mcp"
        ];
      };
    };
  };
in
{
  home = {
    file = {
      ".codex/AGENTS.md".source = ./AGENTS.md;
    };
    activation = {
      warashi-codex-config-merger = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -f ${config.home.homeDirectory}/.codex/config.toml ]; then
          echo "No existing codex config found, skipping merge."
          exit 0
        fi
        run mv ${config.home.homeDirectory}/.codex/config.toml ${config.home.homeDirectory}/.codex/config.backup.toml
        run ${lib.getExe merger} ${config.home.homeDirectory}/.codex/config.toml ${config.home.homeDirectory}/.codex/config.backup.toml ${config-overrides}
      '';
    };
  };
}
