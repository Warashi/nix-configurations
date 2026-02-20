eval "$(aws configure export-credentials --format env)"
unset AWS_PROFILE

exec "$@"
