{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home = {
    file = {
      ".codex/AGENTS.md".source = ./AGENTS.md;
    };
  };
}
