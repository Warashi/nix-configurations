{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.git = {
    enable = true;
    package =
      if pkgs.stdenv.isDarwin then pkgs.git.override { osxkeychainSupport = false; } else pkgs.git;
    includes = [
      { path = "~/.config/git/local"; }
    ];
    settings = {
      user = {
        name = "Shinnosuke Sawada-Dazai";
        email = "shin@warashi.dev";
      };
      alias = {
        sw = "switch";
        sc = "switch -c";
        sch = ''! git fetch origin HEAD && git switch -c "$1" FETCH_HEAD; :'';
        identity = ''! git config user.name "$(git config user.$1.name)"; git config user.email "$(git config user.$1.email)"; git config user.signingkey "$(git config user.$1.signingkey)"; :'';
        delete-merged = "!git branch --merged | cut -c3- | xargs git branch -d";
        fo = ''! git fetch origin "$1:$1"; :'';
        psw = ''! git switch -d HEAD && (git fetch origin "$1:$1" && git switch - && git switch $1) || git switch -; :'';
        copr = ''! gh pr list | fzf-tmux -p 80% | awk '{ print $1 }' | xargs gh pr checkout --detach'';
      };
      core = {
        precomposeunicode = true;
        untrackedCache = true;
        fsmonitor = true;
      };
      push.default = "simple";
      commit = {
        verbose = true;
      };
      pull.ff = "only";
      init.defaultBranch = "main";
      fetch.prune = true;
      ghq.root = [
        "~/worktrees/"
        "~/ghq/"
      ];
      diff = {
        age = {
          textconv = "${pkgs.age}/bin/age -d -i ${config.xdg.configHome}/age/secret-key";
        };
        colorMoved = "default";
      };
    };
    ignores = [
      (builtins.readFile ./ignore)
    ];
    lfs = {
      enable = true;
    };
    signing = {
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK/w9P7ws2J3mqoYBFbqcnIPw2idc8NYsoEF/Z3p87DL";
      signByDefault = true;
    }
    // lib.optionalAttrs pkgs.stdenv.isDarwin {
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
  };
}
