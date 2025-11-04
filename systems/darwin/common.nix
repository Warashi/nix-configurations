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
      inputs.neovim-nightly-overlay.overlays.default
      inputs.emacs-overlay.overlays.default
    ];
  };

  imports = [
    ../../modules/darwin
    ../common.nix
    inputs.sops-nix.darwinModules.sops
    # inputs.mac-app-util.darwinModules.default
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
