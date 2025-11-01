{
  callPackage,
  emacsWithPackagesFromUsePackage,
  emacs,
  ...
}:
emacsWithPackagesFromUsePackage {
  package = emacs;
  config = ./emacs-config.org;
  defaultInitFile = true;
  alwaysEnsure = false;
  alwaysTangle = true;
  extraEmacsPackages =
    epkg: with epkg; [
      treesit-grammars.with-all-grammars
    ];
  override = epkg: {
    term-title = callPackage ./packages/term-title.nix {
      inherit emacs;
      inherit (epkg) melpaBuild;
    };
  };
}
