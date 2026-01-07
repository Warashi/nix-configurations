if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    if which agy &>/dev/null; then
        . "$(agy --locate-shell-integration-path zsh)"
    elif which code &>/dev/null; then
        . "$(code --locate-shell-integration-path zsh)"
    elif which cursor &>/dev/null; then
        . "$(cursor --locate-shell-integration-path zsh)"
    fi
fi
