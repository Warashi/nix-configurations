{ pkgs, ... }:
{
  home.packages = with pkgs; [
    comma
  ];
  programs = {
    nix-index.enable = true;
  };
}
