{ pkgs, lib, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    package = pkgs.direnv.overrideAttrs (oldAttrs: {
      installPhase = ''
        runHook preInstall
        ${oldAttrs.installPhase}
        runHook postInstall
      '';
    });
    config = {
      bash_path = lib.getExe pkgs.bashNonInteractive;
      disable_stdin = true;
      strict_env = true;
      warn_timeout = 0;
    };
    stdlib = ''
      direnv_layout_dir() {
        echo /tmp/direnv/$(pwd | base64 -w 0)
      }
    '';
  };
  programs.direnv-instant = {
    enable = true;
    settings = {
      mux_delay = 0;
    };
  };
}
