#!/bin/sh

OS=$(uname -s)
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  ARCH="x86_64"
elif [ "$ARCH" = "aarch64" ]; then
  ARCH="aarch64"
elif [ "$ARCH" = "arm64" ]; then
  ARCH="aarch64"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

if [ "$OS" = "Linux" ]; then
  TARGET=nixosConfigurations
  TARGET_SYSTEM="${ARCH}-linux"
  TARGET_ATTR="config.system.build.toplevel"
elif [ "$OS" = "Darwin" ]; then
  TARGET=darwinConfigurations
  TARGET_SYSTEM="${ARCH}-darwin"
  TARGET_ATTR="system"
else
  echo "Unsupported OS: $OS"
  exit 1
fi

echo "Building for OS: $OS, Architecture: $ARCH, Target: $TARGET, Target System: $TARGET_SYSTEM"

HOSTS=$(nix eval .#"${TARGET}" --apply builtins.attrNames --json | jq -r '.[]')
if [ -z "$HOSTS" ]; then
  echo "No hosts found for $TARGET."
  exit 0
fi

for host in $HOSTS; do
  echo "Building host: $host"
  SYSTEM=$(nix eval .#${TARGET}.${host}.pkgs.stdenv.system --json | jq -r '.')
  echo "Detected system: $SYSTEM"

  if [ "$SYSTEM" = "$TARGET_SYSTEM" ]; then
    echo "Building for current system: $host"
    nix build --impure --keep-going --no-link --show-trace .#${TARGET}.${host}.${TARGET_ATTR}
    if [ $? -ne 0 ]; then
      echo "Build failed for host: $host"
      exit 1
    fi
  else
    echo "Skipping host: $host (not current system)"
  fi
  echo "Build completed for host: $host"
done
