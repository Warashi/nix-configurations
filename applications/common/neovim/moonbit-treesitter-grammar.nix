{
  tree-sitter,
  symlinkJoin,
  fetchFromGitHub,
  vimUtils,
  neovimUtils,
  runCommand,
}:
let
  language = "moonbit";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "moonbitlang";
    repo = "tree-sitter-moonbit";
    rev = "a5a7e0b9cb2db740cfcc4232b2f16493b42a0c82";
    hash = "sha256-CMI+qSZ/91e/YpFJYtczOGdaRAOfhZiZRFgdPiq1jJ8=";
  };

  queries = vimUtils.toVimPlugin (
    runCommand "nvim-treesitter-queries-moonbit"
      {
        passthru = { inherit language; };
        meta.description = "Queries for ${language} from nvim-treesitter";

      }
      ''
        mkdir -p "$out/queries/moonbit"
        cp ${src}/queries/* "$out/queries/moonbit/"
      ''
  );
  grammer = tree-sitter.buildGrammar {
    inherit language version src;
  };
  grammarPlugin = neovimUtils.grammarToPlugin grammer;
in
symlinkJoin {
  name = "nvim-treesitter-grammar-moonbit";
  paths = [
    grammarPlugin
    queries
  ];
}
