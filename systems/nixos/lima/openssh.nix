{ specialArgs, ... }:
let
  inherit (specialArgs) username;
in
{
  services.openssh = {
    enable = true;
    ports = [
      22
      64022
    ];
    settings = {
      StreamLocalBindUnlink = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
    extraConfig = ''
      AcceptEnv COLORTERM
    '';
  };
}
