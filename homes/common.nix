{
  inputs,
  pkgs,
  config,
  ...
}:
{
  programs = {
    home-manager.enable = true;
    # warashi.emacs.enable = true;
  };

  warashi = {
    services = {
      muscat.package = inputs.muscat.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
    programs = {
      muscat.package = inputs.muscat.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };

  catppuccin = {
    enable = true;
    accent = "blue";
    flavor = "frappe";
  };

  home = {
    preferXdgDirectories = true;

    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/go/bin"
    ];

    sessionVariables = {
      CLAUDE_CONFIG_DIR = "${config.home.homeDirectory}/.claude";
      DENO_NO_UPDATE_CHECK = "1";
      EDITOR = "nvim";
      LS_COLORS = "$(${pkgs.vivid}/bin/vivid generate catppuccin-frappe)";
    };

    shellAliases = {
      tmux = "direnv exec / tmux"; # 自動でtmuxを起動はしないので、起動する時にdirenvの影響を受けないようにこれを定義する。
    };

    stateVersion = "24.11";
  };

  sops = {
    defaultSopsFile = ../secrets/default.yaml;
    age = {
      keyFile = "/var/lib/sops-nix/key.txt";
    };
    secrets = {
      age-public-key = {
        path = "${config.xdg.configHome}/age/public-key";
      };
      age-secret-key = {
        path = "${config.xdg.configHome}/age/secret-key";
      };
    };
  };

  xdg.enable = true;

  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.sops-nix.homeManagerModules.sops
    inputs.warashi-modules.homeModules.default

    ../modules/home-manager

    ../applications/common
  ];
}
