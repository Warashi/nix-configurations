{
  description = "Home Manager configuration of Warashi";

  inputs = {
    # keep-sorted start block=yes
    agent-skills = {
      url = "github:Kyure-A/agent-skills-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    arto = {
      url = "github:arto-app/Arto";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    cage = {
      url = "github:Warashi/cage";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
        git-hooks.follows = "git-hooks";
      };
    };
    catppuccin = {
      url = "github:catppuccin/nix";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    direnv-instant = {
      url = "github:Mic92/direnv-instant";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    fcitx5-hazkey = {
      url = "github:Warashi/nix-fcitx5-hazkey";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    gh-secrets-manager = {
      url = "github:Warashi/gh-secrets-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
        git-hooks.follows = "git-hooks";
      };
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "";
        gitignore.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
    };
    git-mile = {
      url = "github:Warashi/git-mile";
      inputs = {
        devshell.follows = "devshell";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs = {
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    muscat = {
      url = "github:Warashi/muscat";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
        git-hooks.follows = "git-hooks";
      };
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        neovim-src.follows = "neovim-src";
        flake-parts.follows = "flake-parts";
      };
    };
    neovim-src = {
      url = "github:neovim/neovim";
      flake = false;
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/latest";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-facter-modules = {
      url = "github:numtide/nixos-facter-modules";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };
    nixos-lima = {
      url = "github:nixos-lima/nixos-lima";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    nvim-treesitter-main = {
      url = "github:iofq/nvim-treesitter-main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    paneru = {
      url = "github:karinushka/paneru";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vhs-mcp = {
      url = "github:Warashi/vhs-mcp";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
        git-hooks.follows = "git-hooks";
      };
    };
    warashi-modules = {
      url = "github:Warashi/nix-modules";
      inputs = {
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    warashi-nur-packages = {
      url = "github:Warashi/nur-packages";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    # keep-sorted end
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.numtide.com"
      "https://warashi.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "warashi.cachix.org-1:rtCm332XStmyk6/izNzI4hvpj5+14lMCIFbwEAgwAyw="
    ];
  };

  outputs =
    { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        ./flake-module.nix
        # keep-sorted start
        inputs.devshell.flakeModule
        inputs.git-hooks.flakeModule
        inputs.treefmt-nix.flakeModule
        # keep-sorted end
      ];

      hosts = {
        # main laptop (m4 macbook air)
        athena = {
          system = "aarch64-darwin";
        };
        # remote workbench (OCI A1 Flex)
        workbench = {
          system = "aarch64-linux";
        };
        # lima vm
        lima = {
          system = "aarch64-linux";
        };
        # macbook for work
        work = {
          system = "aarch64-darwin";
          username = "shinnosuke.dazai";
        };
      };

      perSystem =
        {
          config,
          pkgs,
          ...
        }:
        {
          pre-commit = {
            check.enable = true;
            settings = {
              src = ./.;
              hooks = {
                actionlint.enable = false;
                treefmt.enable = true;
              };
            };
          };

          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              # keep-sorted start
              deno.enable = true;
              fnlfmt.enable = true;
              keep-sorted.enable = true;
              nixfmt.enable = true;
              shfmt.enable = true;
              stylua.enable = true;
              # keep-sorted end
            };
            settings = {
              formatter = {
                # keep-sorted start block=yes
                deno = {
                  excludes = [
                    "**/*.md" # exclude markdown files
                    "**/facter.json" # nix-factor managed files
                    "./secrets/*.yaml" # sops managed files
                    "**/_sources/generated.json" # nvfetcher generatee sources
                  ];
                };
                nixfmt = {
                  excludes = [
                    "**/node2nix/*.nix" # node2nix generated files
                    "**/_sources/generated.nix" # nvfetcher generatee sources
                  ];
                };
                tombi = {
                  command = pkgs.lib.getExe pkgs.tombi;
                  options = [ "format" ];
                  includes = [ "*.toml" ];
                };
                # keep-sorted end
              };
            };
          };

          devshells.default = {
            devshell = {
              packages = with pkgs; [
                # keep-sorted start
                age
                just
                nix-fast-build
                nix-output-monitor
                node2nix
                sops
                ssh-to-age
                # keep-sorted end
              ];
              startup = {
                pre-commit = {
                  text = config.pre-commit.installationScript;
                };
              };
            };
          };
        };
    };
}
