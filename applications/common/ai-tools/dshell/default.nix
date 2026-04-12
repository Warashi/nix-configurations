{
  pkgs,
  merger,
  ...
}:
pkgs.writeShellApplication {
  name = "dshell";
  runtimeInputs = [
    merger
    pkgs.coreutils
    pkgs.devcontainer
    pkgs.docker-client
    pkgs.docker-credential-helpers
    pkgs.git
  ];
  inheritPath = false;
  text = builtins.readFile ./script.sh;
}
