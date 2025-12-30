{ pkgs, ... }:
let
  sources = pkgs.callPackage ./_sources/generated.nix { };
in
{
  programs.agent-skills = {
    enable = true;
    sources = {
      anthropics = {
        path = sources.anthropics-skills.src;
        subdir = "skills";
      };
      warashi = {
        path = ./skills;
      };
    };
    skills = {
      enable = [
        "skill-creator"
      ];
      enableAll = [
        "warashi"
      ];
    };
    targets = {
      codex = {
        dest = ".codex/skills";
        structure = "copy-tree";
      };
      claude = {
        dest = ".claude/skills";
        structure = "link";
      };
    };
  };
}
