{ config, ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraUpFlags = [
      "--ssh"
      "--accept-routes"
    ];
    authKeyFile = config.sops.secrets.tailscale-authkey.path;
  };
  networking = {
    firewall = {
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
    nameservers = [
      "100.100.100.100"
      "8.8.8.8"
    ];
    search = [ "taileef3.ts.net" ];
  };

  sops.secrets.tailscale-authkey = { };
}
