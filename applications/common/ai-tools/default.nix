{ inputs, pkgs, ... }:
let
  agent-presets = [
    "general"
    "kiro"
    "go"
    "cargo"
    "npm"
    "yarn"
    "pre-commit"
    "swift"
    "vhs-mcp"
  ];
in
{
  home.packages = [
    inputs.vhs-mcp.packages.${pkgs.stdenv.hostPlatform.system}.vhs-mcp
  ];

  warashi.cage = {
    enable = true;
    package = inputs.cage.packages.${pkgs.stdenv.hostPlatform.system}.default;

    wrappedPackages = with inputs.nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}; [
      claude-code
      codex
      gemini-cli
    ];

    config = {
      auto-presets = [
        {
          command = "codex";
          presets = [
            "codex"
          ]
          ++ agent-presets;
        }
        {
          command = "gemini";
          presets = [
            "gemini"
          ]
          ++ agent-presets;
        }
        {
          command = "claude";
          presets = [
            "claude-code"
            "awscli" # for bedrock auth
          ]
          ++ agent-presets;
        }
        {
          command = "codex";
          presets = [
            "codex"
          ]
          ++ agent-presets;
        }
      ];
      presets = {
        # general
        general = {
          allow = [
            {
              path = ".warashi";
              eval-symlinks = true;
            }
            {
              path = "/tmp";
              eval-symlinks = true;
            }
          ];
        };

        # coding agent
        ## kiro or cc-sdd
        kiro = {
          allow = [
            {
              path = ".kiro";
              eval-symlinks = true;
            }
          ];
        };
        claude-code = {
          allow = [
            "."
            "$HOME/.claude"
            "$HOME/.claude.json"
            "$HOME/.claude.json.backup"
            "$HOME/.claude.json.lock"
            "$HOME/.claude.lock"
            {
              path = ".claude";
              eval-symlinks = true;
            }
            {
              path = "CLAUDE.md";
              eval-symlinks = true;
            }
          ];
          allow-keychain = true;
          allow-git = true;
        };
        gemini = {
          allow = [
            "."
            "/dev"
            "$HOME/.gemini"
          ];
          allow-keychain = true;
          allow-git = true;
        };
        codex = {
          allow = [
            "."
            "$HOME/.codex"
          ];
          allow-keychain = true;
          allow-git = true;
        };

        # language-specific
        yarn = {
          allow = [
            "node_modules"
            "$HOME/.yarnrc"
            "$HOME/.cache/yarn"
            "$HOME/Library/Caches/yarn"
          ];
        };
        npm = {
          allow = [
            "node_modules"
            "$HOME/.npm"
            "$HOME/.cache/npm"
            "$HOME/.npmrc"
            "$HOME/Library/Caches/npm"
          ];
        };
        go = {
          allow = [
            "$HOME/go"
            "$HOME/.cache/go-build"
            "$HOME/Library/Caches/go-build"
          ];
        };
        cargo = {
          allow = [
            "$HOME/.cargo"
            "$HOME/.rustup"
            "$HOME/.cache/sccache"
            "$HOME/Library/Caches/sccache"
          ];
        };
        swift = {
          allow = [
            "$HOME/.swiftpm"
            "$HOME/Library/Developer/Xcode/DerivedData"
            "$HOME/Library/Caches/SwiftLint"
            "$HOME/Library/Caches/com.charcoaldesign.swiftformat"
            "$HOME/Library/Caches/org.swift.swiftpm"
          ];
        };

        # other tools
        awscli = {
          allow = [
            "$HOME/.aws"
          ];
        };
        vhs-mcp = {
          allow = [
            "/dev"
          ];
        };
        pre-commit = {
          allow = [
            "$HOME/.cache/pre-commit"
            "$HOME/Library/Caches/pre-commit"
          ];
        };
      };
    };
  };
}
