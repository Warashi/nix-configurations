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
    sandbox = {
      enabled = true;
      allowUnsandboxedCommands = false;
      excludedCommands = [ "ps" ];
    };
    permissions = {
      defaultMode = "plan";
      disableBypassPermissionsMode = "disable";
      deny = [
        "Read(**/.env**)"
        "Write(**/.env**)"
        "Edit(**/.env**)"
        "Read(**/.aws/credentials)"
        "Read(**/.ssh/**)"
      ];
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
    packages = [
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
    ];
    activation = {
      warashi-claude-code-config-merger = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ -f ${config.home.homeDirectory}/.claude/settings.json ]; then
          run mv ${config.home.homeDirectory}/.claude/settings.json ${config.home.homeDirectory}/.claude/settings.backup.json
          run ${lib.getExe merger} ${config.home.homeDirectory}/.claude/settings.json ${config.home.homeDirectory}/.claude/settings.backup.json ${config-overrides}
        fi
      '';
    };
  };
}
