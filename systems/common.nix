{
  inputs,
  self,
  lib,
  pkgs,
  specialArgs,
  ...
}:
let
  inherit (inputs) emacs-overlay;
  inherit (specialArgs) username;
in
{
  imports = [
    ../modules/nix
  ];

  programs.nix.target.system = true;

  environment.shells = [
    pkgs.zsh
    pkgs.fish
  ];
  programs.zsh.enable = true;
  programs.fish.enable = true;
  users.users.${username}.shell = pkgs.fish;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  }
  // lib.optionalAttrs pkgs.stdenv.isLinux { dates = "weekly"; }
  // lib.optionalAttrs pkgs.stdenv.isDarwin {
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
  };

  nix.optimise = {
    automatic = true;
  };

  nix.channel.enable = false;
}
