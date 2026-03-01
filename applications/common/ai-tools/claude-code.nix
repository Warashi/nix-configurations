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
    alwaysThinkingEnabled = true;
    statusLine = {
      type = "command";
      command = ''gojq -r '"[\(.model.display_name)] 💰 \(.cost.total_cost_usd // 0) | ⏱️ \((.cost.total_duration_ms // 0) / 1000 / 60 | floor)m \((.cost.total_duration_ms // 0) / 1000 % 60 | floor)s"';'';
    };
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
                if [ -f ${config.home.homeDirectory}/.claude/settings.json ]; then
                  run cp ${config.home.homeDirectory}/.claude/settings.json ${config.home.homeDirectory}/.claude/settings.backup.json
        	  if [ -f ${config.home.homeDirectory}/.claude/settings.local.json ]; then
                    run ${lib.getExe merger} ${config.home.homeDirectory}/.claude/settings.json ${config.home.homeDirectory}/.claude/settings.backup.json ${config-overrides} ${config.home.homeDirectory}/.claude/settings.local.json
        	  else
                    run ${lib.getExe merger} ${config.home.homeDirectory}/.claude/settings.json ${config.home.homeDirectory}/.claude/settings.backup.json ${config-overrides}
        	  fi
                fi
      '';
    };
  };
}
