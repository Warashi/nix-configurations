{ pkgs, ... }:
let
  sources = pkgs.callPackage ./_sources/generated.nix { };
in
{
  programs.agent-skills = {
    enable = true;
    sources = {
      # keep-sorted start block=yes
      anthropics = {
        path = sources.anthropics-skills.src;
        subdir = "skills";
      };
      leanprover = {
        path = sources.leanprover-skills.src;
        subdir = "skills";
      };
      warashi = {
        path = ./skills;
      };
      # keep-sorted end
    };
    skills = {
      enable = [
        # keep-sorted start
        "lean-proof"
        "skill-creator"
        # keep-sorted end
      ];
      enableAll = [
        "warashi"
      ];
    };
    targets = {
      gemini = {
        dest = ".gemini/skills";
        structure = "link";
      };
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
