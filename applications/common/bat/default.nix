{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      wrap = "never";
      pager = "${pkgs.ov}/bin/ov --quit-if-one-screen -H3 --section-header";
    };
  };
}
