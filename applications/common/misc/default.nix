{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ast-grep
    gfortran
    lean4
  ];
  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
  };
}
