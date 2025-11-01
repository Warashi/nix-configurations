{ pkgs, ... }:
let
  git-wa = pkgs.writeShellApplication {
    name = "git-wa";

    runtimeInputs = [
      pkgs.git
      pkgs.gnused
      pkgs.gnugrep
      pkgs.ghq
      pkgs.coreutils
    ];

    text = builtins.readFile ./git-wa.sh;
  };
in
{
  home.packages = [
    git-wa
  ];
}
