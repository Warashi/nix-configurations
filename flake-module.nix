{
  self,
  inputs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkOption types;
  getDefaultPlatform =
    system: if (lib.last (lib.splitString "-" system)) == "linux" then "nixos" else "darwin";
  systemConfigurations =
    platform: hostname: attrs:
    if platform == "nixos" then
      { nixosConfigurations."${hostname}" = inputs.nixpkgs.lib.nixosSystem attrs; }
    else if platform == "darwin" then
      { darwinConfigurations."${hostname}" = inputs.darwin.lib.darwinSystem attrs; }
    else
      throw "unreachable";
  forEachAttrs = attrs: f: builtins.mapAttrs f attrs;
  maybePath = path: if builtins.pathExists path then path else null;
in
{
  options.hosts = mkOption {
    default = { };
    type = types.attrsOf (
      types.submodule (
        { name, ... }:
        {
          options = {
            system = mkOption {
              type = types.str;
            };
            platform = mkOption {
              default = getDefaultPlatform config.hosts.${name}.system;
              type = types.str;
            };
            modules = mkOption {
              default = [ ];
              type = types.listOf types.path;
            };
            username = mkOption {
              default = "warashi";
              type = types.str;
            };
            specialArgs = mkOption {
              default = { };
              type = types.attrs;
            };
          };
        }
      )
    );
  };

  config = rec {
    flake = lib.foldAttrs (host: acc: host // acc) { } (
      builtins.attrValues (
        forEachAttrs config.hosts (
          name: cfg:
          systemConfigurations cfg.platform name {
            inherit (cfg) system;
            modules =
              lib.filter (x: x != null) [
                (maybePath ./systems/${cfg.platform}/${name})
                (maybePath ./homes/${cfg.platform}/${name})
              ]
              ++ cfg.modules;
            specialArgs = {
              inherit self inputs;
              inherit (cfg) username;
            }
            // cfg.specialArgs;
          }
        )
      )
    );
    perSystem =
      { lib, system, ... }:
      {
        checks =
          let
            currentSystemConfigurations = lib.filterAttrs (k: v: v.pkgs.system == system) (
              (lib.optionalAttrs (flake ? nixosConfigurations) flake.nixosConfigurations)
              // (lib.optionalAttrs (flake ? darwinConfigurations) flake.darwinConfigurations)
            );
          in
          builtins.mapAttrs (k: v: v.config.system.build.toplevel) currentSystemConfigurations;
      };
  };
}
