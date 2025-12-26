{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  merger = pkgs.callPackage ./merger { };
  config-overrides = (pkgs.formats.json { }).generate "claude-settings-override.json" {
    env = {
      ANTHROPIC_MODEL = "opusplan";
    };
    permissions = {
      defaultMode = "plan";
    };
    alwaysThinkingEnabled = true;
    enabledPlugins = {
      "gopls-lsp@claude-plugins-official" = true;
    };
  };
in
{
  home = {
    file = {
      ".claude/CLAUDE.md".source = ./AGENTS.md;
    };
    activation = {
      warashi-claude-code-config-merger = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -f ${config.home.homeDirectory}/.claude/settings.json ]; then
          echo "No existing claude-code config found, skipping merge."
          exit 0
        fi
        run mv ${config.home.homeDirectory}/.claude/settings.json ${config.home.homeDirectory}/.claude/settings.backup.json
        run ${lib.getExe merger} ${config.home.homeDirectory}/.claude/settings.json ${config.home.homeDirectory}/.claude/settings.backup.json ${config-overrides}
      '';
    };
  };
}
