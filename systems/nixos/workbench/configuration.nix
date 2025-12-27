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
}
