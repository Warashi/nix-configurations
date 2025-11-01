{ pkgs, ... }:
let
  rgfind = pkgs.writeShellApplication {
    name = "rgfind";
    text = ''
      rg -0 -l "$@" | xargs -0 readlink -f
    '';
  };
in
{
  home.packages = [
    rgfind
  ];
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--hidden"
      "--glob=!.git/"
    ];
  };
}
