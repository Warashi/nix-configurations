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
      # treesit-grammars.with-all-grammars # tree-sitter-razor-0-unstable-2016-07-08 is broken
    ];
  override = epkg: {
    term-title = callPackage ./packages/term-title.nix {
      inherit emacs;
      inherit (epkg) melpaBuild;
    };
  };
}
