{
  programs.agent-skills = {
    enable = true;
    sources = {
      warashi = {
        path = ./skills;
      };
    };
    skills.enableAll = [ "warashi" ];
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
