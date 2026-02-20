{ pkgs, ... }:
let
  aws-profile-run = pkgs.callPackage ./aws-profile-run { };
in
{
  home.packages = [
    aws-profile-run
    pkgs.awscli2
  ];
}
