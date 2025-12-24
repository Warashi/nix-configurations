{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home = {
    file = {
      ".claude/CLAUDE.md".source = ./AGENTS.md;
    };
  };
}
