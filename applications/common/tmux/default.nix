{
  inputs,
  pkgs,
  ...
}:
let
  nodePkgs = pkgs.callPackage ./node2nix { };
in
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    shortcut = "g";
    terminal = "tmux-256color";
    sensibleOnTop = false;
    extraConfig = builtins.readFile ./extra-config.tmux;
    plugins = [
    ];
  };
  catppuccin.tmux.extraConfig = ''
    set -g @catppuccin_window_status_style "rounded"

    set -g status-right-length 100
    set -g status-left-length 100
    set -g status-left ""
    set -g status-right "#{E:@catppuccin_status_application}"
    set -agF status-right "#{E:@catppuccin_status_cpu}"
    set -ag status-right "#{E:@catppuccin_status_session}"
    set -ag status-right "#{E:@catppuccin_status_uptime}"
    set -agF status-right "#{E:@catppuccin_status_battery}"
  '';

  home = {
    file = {
      ".gitmux.conf" = {
        source = ./gitmux.conf;
      };
    };
    packages = [
      nodePkgs.editprompt
      pkgs.gitmux
      # inputs.tmux-mvr.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
