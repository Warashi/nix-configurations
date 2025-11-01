{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.nix;
in
{
  options.programs.nix.target = {
    system = mkEnableOption "";
    user = mkEnableOption "";
    otherDistroUser = mkEnableOption "";
  };

  config = mkMerge [
    (mkIf (cfg.target.system or cfg.target.otherDistroUser) {
      nix = {
        settings = {
          # error: cannot link '/nix/store/.tmp-link' to '/nix/store/.links/...': File exists
          # https://github.com/NixOS/nix/issues/7273
          auto-optimise-store = pkgs.stdenv.isLinux;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          substituters = [
            "https://nix-community.cachix.org"
            "https://warashi.cachix.org"
          ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "warashi.cachix.org-1:rtCm332XStmyk6/izNzI4hvpj5+14lMCIFbwEAgwAyw="
          ];
          trusted-users = [
            "root"
            "@wheel"
          ]
          ++ optional pkgs.stdenv.isDarwin "@admin";
          sandbox = if pkgs.stdenv.isDarwin then false else true;
          warn-dirty = false;
        };

        # for flake (e.g. nix shell)
        registry.nixpkgs.flake = inputs.nixpkgs;
        # for legacy channel (e.g. nix-shell)
        settings.nix-path = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];

        extraOptions = ''
          max-silent-time = 3600
        '';
      };
    })
    (mkIf (cfg.target.user or cfg.target.otherDistroUser) {
      nix.settings.use-xdg-base-directories = true;
    })
  ];
}
