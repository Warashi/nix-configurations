{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.programs.warashi.emacs;
in
{
  options = with types; {
    programs.warashi.emacs = {
      enable = mkEnableOption "Enable emacs configuration";
      package = mkOption {
        type = package;
        default = pkgs.emacs;
        description = "Emacs package to use";
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = [
        (pkgs.callPackage ./package.nix { emacs = cfg.package; })

        pkgs.age # used by age.el
      ];

      file = {
        emacs-early-init-el = {
          target = ".emacs.d/early-init.el";
          source = ./early-init.el;
        };
        emacs-ddskk-init-el = {
          target = ".emacs.d/ddskk/init.el";
          source = ./ddskk/init.el;
        };
        emacs-terminfo = {
          recursive = true;
          target = ".terminfo";
          source = pkgs.runCommand "emacs-terminfo" { } ''
            ${pkgs.ncurses}/bin/tic -o $out ${pkgs.emacs.src}/etc/e/eterm-color.ti
          '';
        };
      };
    };
  };
}
