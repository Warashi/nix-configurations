{
  config,
  modulesPath,
  pkgs,
  lib,
  inputs,
  specialArgs,
  ...
}:
let
  inherit (specialArgs) username;
in
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.nixos-lima.nixosModules.lima
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "lima";

  # Give users in the `wheel` group additional rights when connecting to the Nix daemon
  # This simplifies remote deployment to the instance's nix store.
  nix.settings.trusted-users = [ "@wheel" ];

  services.lima.enable = true;

  # system mounts
  boot = {
    kernelParams = [ "console=tty0" ];
    loader.grub = {
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };
  fileSystems."/boot" = {
    device = lib.mkForce "/dev/vda1"; # /dev/disk/by-label/ESP
    fsType = "vfat";
  };
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
    options = [
      "noatime"
      "nodiratime"
      "discard"
    ];
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  sops.secrets = lib.mkForce { };

  users = {
    mutableUsers = lib.mkForce true;
    users.${username} = {
      home = lib.mkForce "/home/${username}.linux";
      hashedPasswordFile = lib.mkForce null;
    };
  };
}
