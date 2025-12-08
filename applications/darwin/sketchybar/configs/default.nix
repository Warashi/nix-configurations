{ callPackage, lib, ... }:
let
  files = lib.naturalSort (
    builtins.filter (x: lib.hasSuffix ".sh" x || lib.hasSuffix ".nix" x && x != "default.nix") (
      builtins.attrNames (builtins.readDir ./.)
    )
  );
  readFile =
    script:
    if lib.hasSuffix ".sh" script then
      builtins.readFile (./. + "/${script}")
    else if lib.hasSuffix ".nix" script then
      callPackage (./. + "/${script}") { }
    else
      "";
  scripts = builtins.map readFile files;
in
lib.concatStringsSep "\n" scripts
