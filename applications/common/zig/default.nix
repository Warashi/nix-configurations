{ inputs, pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = [
    inputs.zig-overlay.packages.${system}.master
    inputs.zls.packages.${system}.zls
  ];
}
