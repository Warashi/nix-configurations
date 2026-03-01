{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ast-grep
    gfortran
  ];
  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
  };
}
