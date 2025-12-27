#!/usr/bin/env bash

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

HOSTS=$(nix eval ".#${TARGET}" --apply builtins.attrNames --json | jq -r '.[]')
if [ -z "$HOSTS" ]; then
  echo "No hosts found for $TARGET."
  exit 0
fi

BUILD_TARGETS=(".#devShells.${TARGET_SYSTEM}.default ")

for host in $HOSTS; do
  SYSTEM=$(nix eval ".#${TARGET}.${host}.pkgs.stdenv.system" --json | jq -r '.')
  if [ "$SYSTEM" = "$TARGET_SYSTEM" ]; then
    BUILD_TARGETS+=(".#${TARGET}.${host}.${TARGET_ATTR}")
  fi
done

nix build --accept-flake-config --keep-going --no-link --show-trace --eval-system "${TARGET_SYSTEM}" --print-out-paths ${BUILD_TARGETS[@]}
