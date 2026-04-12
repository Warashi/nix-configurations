{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp = {
    useTmpfs = false;
  };

  networking.hostName = "workbench";
  networking.useNetworkd = true;
  systemd.network.enable = true;
  security.pam = {
    rssh.enable = true;
    services = {
      sudo = {
        rssh = true;
      };
      sshd = {
        enableGnomeKeyring = true;
      };
    };
  };
  services = {
    gnome = {
      gnome-keyring = {
        enable = true;
      };
    };
  };
}
