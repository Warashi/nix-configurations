{ pkgs, ... }:
{
  programs.warashi.emacs = {
    package = pkgs.emacs-nox;
  };
}
