{
  programs.bash = {
    enable = true;
    enableVteIntegration = true;
    initExtra = ''
      if [[ "$TERM_PROGRAM" == "vscode" ]]; then
        if which cursor > /dev/null 2>&1; then
          . "$(cursor --locate-shell-integration-path bash)"
        elif which code > /dev/null 2>&1; then
          . "$(code --locate-shell-integration-path bash)"
        fi
      fi
    '';
  };
}
