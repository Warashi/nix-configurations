{ lib, ... }:
{
  imports = (
    builtins.map (modules: ./. + "/${modules}") (
      builtins.filter (x: x != "default.nix" && lib.strings.hasSuffix ".nix" x) (
        builtins.attrNames (builtins.readDir ./.)
      )
    )
  );
}
