if test -S $SSH_AUTH_SOCK && test $SSH_AUTH_SOCK != $HOME/.ssh/ssh_auth_sock; then
	ln -sf $SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
fi
if test -S $HOME/.ssh/ssh_auth_sock; then
	export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
fi
