{
  pkgs,
  ...
}:
pkgs.writeShellApplication {
  name = "dshell";
  runtimeInputs = [
    pkgs.coreutils
    pkgs.devcontainer
    pkgs.docker-client
    pkgs.git
  ];
  inheritPath = false;
  text = builtins.readFile ./script.sh;
}
