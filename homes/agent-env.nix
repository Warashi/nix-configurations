{ pkgs, ... }:
let
  agent-nane = "warashi-agent[bot]";
  agent-email = "264713104+warashi-agent[bot]@users.noreply.github.com";
  agent-env = {
    GIT_AUTHOR_NAME = agent-nane;
    GIT_AUTHOR_EMAIL = agent-email;
    GIT_COMMITTER_NAME = agent-nane;
    GIT_COMMITTER_EMAIL = agent-email;
  };
in
{
  home.file = {
    ".codex/config.local.toml".source = (pkgs.formats.toml { }).generate "codex-config-local.toml" {
      shell_environment_policy = {
        set = {
        }
        // agent-env;
      };
    };
    ".claude/settings.local.json".source = (pkgs.formats.json { }).generate "claude-config-local.json" {
      env = {
      }
      // agent-env;
    };
  };
}
