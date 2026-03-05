{
  inputs,
  pkgs,
  config,
  ...
}:
let
  muscat = inputs.muscat.packages.${pkgs.stdenv.hostPlatform.system}.default;
  terminal-notifier = pkgs.writeShellApplication {
    name = "terminal-notifier";
    runtimeInputs = [ muscat ];
    text = ''
      exec muscat exec -- terminal-notifier "$@"
    '';
  };
in
{
  warashi.programs.muscat = {
    enable = true;
    extraSymlinks = [
      "lemonade"
      "pbcopy"
      "pbpaste"
      "xdg-open"
    ];
  };

  home.packages = [
    terminal-notifier
  ];

  xdg.configFile = {
    "muscat/config.json".source = (pkgs.formats.json { }).generate "muscat-config.json" {
      Addr = "localhost:45000";
    };
  };
}
