{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home = {
    file = {
      ".gemini/GEMINI.md".source = ./AGENTS.md;
    };
  };
}
