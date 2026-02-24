{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gojq
  ];
  programs.jq = {
    enable = true;
  };
}
