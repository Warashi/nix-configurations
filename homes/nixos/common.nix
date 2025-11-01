{
  inputs,
  specialArgs,
  ...
}:
let
  inherit (specialArgs) username;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      imports = [
        ../common.nix
        ../../modules/nix
      ];

      home.homeDirectory = "/home/${username}";
      programs.nix.target.user = true;
    };
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs specialArgs;
    };
  };
}
