{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home = {
    packages = [
      inputs.vhs-mcp.packages.${pkgs.stdenv.hostPlatform.system}.vhs-mcp
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.spec-kit
    ];
    file = {
      ".codex/AGENTS.md".source = ./AGENTS.md;
      ".claude/CLAUDE.md".source = ./AGENTS.md;
      ".gemini/GEMINI.md".source = ./AGENTS.md;
    };
  };
}
