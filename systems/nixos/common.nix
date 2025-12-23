{
  config,
  username,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/nixos
    ../common.nix
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    inputs.nixos-facter-modules.nixosModules.facter
    inputs.catppuccin.nixosModules.catppuccin
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.emacs-overlay.overlays.default
    ];
  };

  documentation.man.enable = false; # CI で mandb がこけるので無効化

  catppuccin = {
    enable = true;
    accent = "blue";
    flavor = "frappe";
  };

  sops = {
    defaultSopsFile = ../../secrets/default.yaml;
    age = {
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };

  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  programs.ssh.startAgent = true;

  virtualisation.docker = {
    enable = true;
  };

  programs.nix-ld = {
    enable = true;
  };

  zramSwap = {
    enable = true;
  };

  users = {
    mutableUsers = false;

    users.${username} = {
      home = "/home/${username}";
      isNormalUser = true;
      linger = true;
      autoSubUidGidRange = true;
      hashedPasswordFile =
        if config.sops.secrets ? login-password then config.sops.secrets.login-password.path else null;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK/w9P7ws2J3mqoYBFbqcnIPw2idc8NYsoEF/Z3p87DL"
      ];
    };
  };

  sops.secrets.login-password.neededForUsers = true;

  system.stateVersion = "24.11";
}
