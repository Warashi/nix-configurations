{ pkgs, ... }:
{
  home.packages = [
    pkgs.docker-client
    pkgs.docker-credential-helpers
    pkgs.lima
  ];
}
