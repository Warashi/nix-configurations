{ pkgs, ... }:
{
  home.packages = [
    (pkgs.gitu.overrideAttrs { doCheck = false; })
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
