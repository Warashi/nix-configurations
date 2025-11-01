if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    if which cursor &>/dev/null; then
        . "$(cursor --locate-shell-integration-path zsh)"
    elif which code &>/dev/null; then
        . "$(code --locate-shell-integration-path zsh)"
    fi
fi
