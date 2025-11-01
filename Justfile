nix := "nom"
os := os()
arch := arch()
host := `uname -n`

system := if os() == "macos" {
  "aarch64-darwin"
} else if os() == "linux" {
  if arch() == "x86_64" { "x86_64-linux" }
  else if arch() == "aarch64" { "aarch64-linux" }
  else { error("Unsupported architecture: " + arch()) }
} else { error("Unsupported OS: " + os()) }

# ===== レシピ =====

_default:
  @just --list

# デフォルト（マシン自身）
build:
  just build-for {{host}}

# デフォルト（マシン自身）
switch:
  just switch-for {{host}}

build-for HOST:
  just {{ if os() == "macos" { "darwin-rebuild-for" } else { "nixos-rebuild-for" } }} {{HOST}}

switch-for HOST:
  just {{ if os() == "macos" { "darwin-rebuild-switch-for" } else { "nixos-rebuild-switch-for" } }} {{HOST}}

_darwin-rebuild-for HOST:
  {{nix}} build --impure --keep-going --no-link --show-trace --system {{system}} \
    .#darwinConfigurations.{{HOST}}.system

_darwin-rebuild-switch-for HOST:
  sudo darwin-rebuild switch --flake .#{{HOST}}

_nixos-rebuild-for HOST:
  {{nix}} build --impure --keep-going --no-link --show-trace --system {{system}} \
    .#nixosConfigurations.{{HOST}}.config.system.build.toplevel

_nixos-rebuild-switch-for HOST:
  sudo nixos-rebuild switch --flake .#{{HOST}}

# 便利エイリアス
work-build:
  just build-for {{system}} work

# 便利エイリアス
work-switch:
  just switch-for work
