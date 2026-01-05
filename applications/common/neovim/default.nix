{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  lnsync = pkgs.callPackage ./lnsync { };
  lnsyncJoin =
    args_@{
      name,
      paths,
      postBuild ? "",
      ...
    }:
    let
      mapPaths =
        f: paths:
        map (
          path:
          if path == null then
            null
          else if lib.isList path then
            mapPaths f path
          else
            f path
        ) paths;
      args = {
        paths = mapPaths (path: "${path}") paths;
        passAsFile = [ "paths" ];
      };
    in
    pkgs.runCommand name args ''
      mkdir -p $out
      for i in $(cat $pathsPath); do
        ${lnsync}/bin/lnsync $i $out
      done
      ${postBuild}
    '';

  sources = pkgs.callPackage ./_sources/generated.nix { };
  neovim-with-deps = pkgs.writeShellApplication {
    name = "nvim";
    runtimeInputs = with pkgs; [
      inputs.neovim-nightly-overlay.packages.${stdenv.hostPlatform.system}.default

      # keep-sorted start
      copilot-language-server
      deno
      emmylua-ls
      gopls
      rust-analyzer
      # keep-sorted end
    ];
    text = ''
      exec nvim "$@"
    '';
  };
  replaced-vars = {
    skk_jisyo_l = "${sources.skk-dict.src}/json/SKK-JISYO.L.json";
    ddc_config_ts = pkgs.writeTextFile {
      name = "ddc-config.ts";
      text = builtins.readFile ./config/ddc.ts;
    };
    merged_plugins = lnsyncJoin {
      name = "nvim-plugins";
      paths =
        (lib.filter (x: x != null) (
          builtins.map (s: if s ? src then s.src else null) (lib.attrsets.attrValues sources)
        ))
        ++ (
          let
            ts = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
            moonbit = pkgs.callPackage ./moonbit-treesitter-grammar.nix { };
          in
          [
            ts
            moonbit
          ]
        );
      postBuild = ''
        rm -f $out/deno.json $out/deno.jsonc
      '';
    };
  };
  matchAllPlaceholders =
    string:
    let
      r = builtins.match "[^@]*@([a-zA-Z_][0-9A-Za-z_'-]*)@(.*)" string;
      result = if r == null then [ ] else lib.lists.take ((builtins.length r) - 1) r;
      rest = if r == null then "" else builtins.elemAt (lib.lists.drop ((builtins.length r) - 1) r) 0;
    in
    result ++ (if (builtins.length result) > 0 then (matchAllPlaceholders rest) else [ ]);
  replaceVars =
    fromPath: toDir:
    pkgs.replaceVarsWith {
      src = fromPath;
      replacements =
        let
          exist-patterns = matchAllPlaceholders (builtins.readFile fromPath);
        in
        lib.attrsets.filterAttrs (
          n: _: if exist-patterns == null then false else (builtins.elem n exist-patterns)
        ) replaced-vars;
      dir = toDir;
      ieExecutable = false;
    };
  config = pkgs.symlinkJoin {
    name = "nvim-lua-config";
    paths = builtins.map (
      path: replaceVars path (builtins.dirOf (lib.path.removePrefix ./config path))
    ) (lib.filesystem.listFilesRecursive ./config);
  };
in
{
  config = {
    home.packages = [
      neovim-with-deps
    ];
    xdg = {
      configFile = {
        "nvim" = {
          source = config;
          recursive = true;
        };
      };
    };
  };
}
