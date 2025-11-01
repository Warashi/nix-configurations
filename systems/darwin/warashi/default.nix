{ pkgs, ... }:
{
  imports = [
    ../common.nix
    ../desktop.nix
    ./homebrew.nix
  ];

  networking.hostName = "warashi";
}
