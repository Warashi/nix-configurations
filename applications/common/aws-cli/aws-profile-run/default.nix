{
  pkgs,
  ...
}:
pkgs.writeShellApplication {
  name = "aws-profile-run";
  runtimeInputs = [
    pkgs.awscli2
  ];
  text = builtins.readFile ./script.sh;
}
