{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.git-mile.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
