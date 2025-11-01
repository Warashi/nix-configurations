{
  imports = [
    ../common.nix
    ../services/tailscale

    ./configuration.nix
    ./disk-config.nix
    ./hardware-configuration.nix
    ./openssh.nix
  ];
}
