{
  config,
  inputs,
  pkgs,
  ...
}:
let
  difit = pkgs.callPackage ./difit { };
in
{
  home = {
    packages = [
      difit
      inputs.vhs-mcp.packages.${pkgs.stdenv.hostPlatform.system}.vhs-mcp
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.spec-kit
    ];
  };
}
