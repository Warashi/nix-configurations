{ pkgs, ... }:
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
  };
  programs.direnv-instant = {
    enable = true;
    settings = {
      mux_delay = 0;
    };
  };
}
