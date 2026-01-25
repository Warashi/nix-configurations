{ pkgs, lib, ... }:
let
  sources = pkgs.callPackage ./_sources/generated.nix { };
in
{
  home.packages = [
    pkgs.babelfish
  ];
  programs.fish = {
    enable = true;
    preferAbbrs = true;
    shellAbbrs = {
      e = "emacsclient";
      g = "git";
      gt = "gitu";
      k = "kubectl";
      kx = "kubectx";
      tn = "tmux new-session -AD -s $(hostname -s)";
      v = "nvim";
      ":q" = "exit";
    };
    interactiveShellInit = ''
      # 1Password Plugins
      if test -e "$HOME/.config/op/plugins.sh"
        source "$HOME/.config/op/plugins.sh"
      end

      # SSH_AUTH_SOCK
      if test -S $SSH_AUTH_SOCK && not test $SSH_AUTH_SOCK = $HOME/.ssh/ssh_auth_sock
        ln -sf $SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
      end
      if test -S $HOME/.ssh/ssh_auth_sock
        set -x SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
      end

      # event handler for OSC 7
      # event hander は autoload で読み込めないため、ここで定義する
      function osc7_send_pwd --on-event fish_prompt
        printf "\e]7;file://%s%s\e\\\\" (hostname) "$PWD"
      end

      if string match -q "$TERM_PROGRAM" "vscode"
        if which cursor > /dev/null 2>&1
          . (cursor --locate-shell-integration-path fish)
        else if which code > /dev/null 2>&1
          . (code --locate-shell-integration-path fish)
        end
      end
    ''
    + lib.optionalString pkgs.stdenv.isDarwin ''
      if string match -q "$TERM" "xterm-ghostty"
        set -x COLORTERM "truecolor"
        set -x TERMINFO "/Applications/Ghostty.app/Contents/Resources/terminfo"
      end
    '';
    plugins = lib.filter (x: x != null) (
      builtins.map (
        s:
        if s ? pname && s ? src then
          {
            name = s.pname;
            src = s.src;
          }
        else
          null
      ) (lib.attrsets.attrValues sources)
    );
  };
}
