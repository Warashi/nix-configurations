{
  inputs,
  pkgs,
  specialArgs,
  ...
}:
let
  inherit (specialArgs) username;
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      imports = [
        ../common.nix
        ../../modules/nix

        inputs.mac-app-util.homeManagerModules.default
      ];

      home = rec {
        homeDirectory = "/Users/${username}";
        packages = with pkgs; [
          # without this, the older builtin `less` would be used
          less
        ];
        sessionPath = [
          "${homeDirectory}/.mint/bin"
          "/opt/homebrew/bin"
        ];
      };

      programs.nix.target.user = true;
    };

    backupFileExtension = "backup";

    extraSpecialArgs = {
      inherit inputs specialArgs;
    };
  };
}
