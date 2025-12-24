{
  config,
  pkgs,
  lib,
  ...
}:
let
  ov = lib.getExe' pkgs.ov "ov";
  delta = lib.getExe' config.programs.delta.finalPackage "delta";
  catppuccin-feature = "catppuccin-${config.catppuccin.delta.flavor}";
in
{
  programs = {
    git.iniContent = {
      core.pager = lib.mkForce "${delta} --pager='${ov} --quit-if-one-screen'";
      pager = {
        show = "${delta} --pager='${ov} --quit-if-one-screen --header 3'";
        diff = "${delta} --features ov-diff";
        log = "${delta} --features ov-log";
      };
    };
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
        navigate = true;
        side-by-side = true;
        ov-diff = {
          features = catppuccin-feature;
          pager = "${ov} --quit-if-one-screen --section-delimiter '^(commit|added:|removed:|renamed:|Δ)' --section-header --pattern '•'";
        };
        ov-log = {
          features = catppuccin-feature;
          pager = "${ov} --quit-if-one-screen --section-delimiter '^commit' --section-header-num 3";
        };
      };
    };
  };
}
