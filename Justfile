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

# デフォルト build （マシン自身）
build: (build-for host)

# デフォルト switch （マシン自身）
switch: (switch-for host)

# 仕事マシン用 build
work-build: (build-for "work")

# 仕事マシン用 switch
work-switch: (switch-for "work")

# マシンを指定しての build
build-for HOST:
  just {{ if os() == "macos" { "_darwin-rebuild-for" } else { "_nixos-rebuild-for" } }} {{HOST}}

# マシンを指定しての switch
switch-for HOST:
  just {{ if os() == "macos" { "_darwin-rebuild-switch-for" } else { "_nixos-rebuild-switch-for" } }} {{HOST}}

_darwin-rebuild-for HOST:
  {{nix}} build --accept-flake-config --keep-going --no-link --show-trace --system {{system}} .#darwinConfigurations.{{HOST}}.system

_darwin-rebuild-switch-for HOST:
  sudo darwin-rebuild switch --flake .#{{HOST}}

_nixos-rebuild-for HOST:
  {{nix}} build --accept-flake-config --keep-going --no-link --show-trace --system {{system}} .#nixosConfigurations.{{HOST}}.config.system.build.toplevel

_nixos-rebuild-switch-for HOST:
  sudo nixos-rebuild switch --accept-flake-config --flake .#{{HOST}}
