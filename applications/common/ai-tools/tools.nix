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
  };
}
