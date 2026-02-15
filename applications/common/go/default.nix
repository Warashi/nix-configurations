{ lib, ... }:
{
  programs.go = {
    enable = true;
    env = {
      GOCACHE = "/tmp/go-cache/build";
      GOMODCACHE = "/tmp/go-cache/mod";
    };
  };
}
