{ specialArgs, ... }:
let
  inherit (specialArgs) username;
in
{
  services.openssh = {
    enable = true;
    # settings = {
    #   StreamLocalBindUnlink = true;
    #   PermitRootLogin = "no";
    #   PasswordAuthentication = false;
    #   KbdInteractiveAuthentication = false;
    # };
    # hostKeys = [
    #   {
    #     path = "/etc/ssh/ssh_host_ed25519_key";
    #     type = "ed25519";
    #   }
    # ];
    # extraConfig = ''
    #   AcceptEnv COLORTERM
    # '';
  };
}
