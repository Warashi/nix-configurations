{
  config,
  pkgs,
  lib,
  ...
}:
let
  sources = pkgs.callPackage ./_sources/generated.nix { };
in
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = false;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;
    enableVteIntegration = false;
    defaultKeymap = "emacs";
    zprof.enable = false;

    history = {
      append = true;
      expireDuplicatesFirst = true;
      extended = true;
      ignoreAllDups = true;
    };

    initContent = ''
      ${builtins.readFile ./scripts/setopts.zsh}
      ${builtins.readFile ./scripts/ssh-auth-sock.zsh}
      ${builtins.readFile ./scripts/edit-command-line.zsh}
      ${builtins.readFile ./scripts/tab-title.zsh}
      ${builtins.readFile ./scripts/vscode.zsh}
      ${lib.optionalString pkgs.stdenv.isDarwin (builtins.readFile ./scripts/darwin-ghostty.zsh)}
      ${builtins.readFile ./scripts/denovo.zsh}
      ${builtins.readFile ./scripts/local.zsh}
    '';

    plugins = with sources; [
      {
        name = "zsh-tab-title";
        inherit (trystan2k-zsh-tab-title) src;
      }
    ];
  };
}
