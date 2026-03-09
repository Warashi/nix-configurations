{
  pkgs,
  merger,
  ...
}:
let
  devcontainer = pkgs.devcontainer.override {
    nodejs_20 = pkgs.nodejs;
  };
in
pkgs.writeShellApplication {
  name = "dshell";
  runtimeInputs = [
    merger
    devcontainer

    pkgs.coreutils
    pkgs.docker-client
    pkgs.git
  ];
  inheritPath = false;
  text = builtins.readFile ./script.sh;
}
