{
  inputs,
  specialArgs,
  ...
}:
let
  inherit (specialArgs) username;
in
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.emacs-overlay.overlays.default
    ];
  };

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
