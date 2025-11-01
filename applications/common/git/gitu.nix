{ pkgs, ... }:
{
  home.packages = [
    pkgs.gitu
  ];

  xdg.configFile = {
    "gitu/config.toml" = {
      enable = true;
      source = (pkgs.formats.toml { }).generate "gitu/config.toml" {
        general = {
          refresh_on_file_change.enabled = false;
        };
      };
    };
  };
}
