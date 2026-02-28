{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_latest;
    env = {
      GOCACHE = "/tmp/go-cache/build";
      GOMODCACHE = "/tmp/go-cache/mod";
    };
  };
}
