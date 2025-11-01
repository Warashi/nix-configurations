{
  inputs,
  specialArgs,
  ...
}:
let
  inherit (specialArgs) username;
in
{

  imports = [
    ../../modules/darwin
    ../common.nix
    inputs.sops-nix.darwinModules.sops
  ];

  sops = {
    defaultSopsFile = ../../secrets/default.yaml;
    age = {
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };

  users.users.${username}.home = "/Users/${username}";

  nix.enable = true;

  system.primaryUser = username;

  system.stateVersion = 5;
}
