{
  tree-sitter,
  fetchFromGitHub,
}:
tree-sitter.buildGrammar {
  language = "moonbit";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "moonbitlang";
    repo = "tree-sitter-moonbit";
    rev = "a5a7e0b9cb2db740cfcc4232b2f16493b42a0c82";
    hash = "sha256-CMI+qSZ/91e/YpFJYtczOGdaRAOfhZiZRFgdPiq1jJ8=";
  };
}
