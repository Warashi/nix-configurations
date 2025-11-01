{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nix-output-monitor
  ];

  programs = {
    nix-your-shell = {
      enable = true;
    };
  };
}
