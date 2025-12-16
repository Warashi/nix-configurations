{
  specialArgs,
  lib,
  ...
}:
let
  inherit (specialArgs) username;
in
{
  imports = [
    ../common.nix
  ];

  home-manager = {
    users.${username} = {
      imports = [
        ../headless
      ];
      home.homeDirectory = lib.mkForce "/home/${username}.linux";
      sops.secrets = lib.mkForce { };
    };
  };
}
