{ inputs, pkgs, ... }:
let
  gh-mcp = pkgs.writeShellApplication rec {
    name = "gh-mcp";
    passthru = {
      pname = name;
    };
    runtimeInputs = [
      pkgs.gh
      pkgs.github-mcp-server
    ];
    text = ''
      GITHUB_PERSONAL_ACCESS_TOKEN=$(gh auth token)
      export GITHUB_PERSONAL_ACCESS_TOKEN
      exec github-mcp-server "$@"
    '';
  };
in
{
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
    extensions = with pkgs; [
      gh-poi
      gh-dash
      gh-copilot
      gh-mcp

      inputs.gh-secrets-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
