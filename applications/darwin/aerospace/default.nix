{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.services.warashi.aerospace;
in
{
  options = with types; {
    services.warashi.aerospace = {
      enable = mkEnableOption "warashi's AeroSpace configs";
    };
  };

  config = mkIf cfg.enable {
    services.aerospace = {
      enable = true;
      settings = {
        enable-normalization-flatten-containers = true;
        enable-normalization-opposite-orientation-for-nested-containers = true;
        default-root-container-layout = "accordion";

        on-focused-monitor-changed = [ ];

        on-window-detected = [
          {
            "if" = {
              app-id = "org.alacritty";
            };
            run = [
              "layout floating"
            ];
          }
          {
            "if" = {
              app-id = "com.tinyspeck.slackmacgap";
            };
            run = [
              "move-node-to-workspace 3"
            ];
          }
          {
            "if" = {
              app-id = "com.hnc.Discord";
            };
            run = [
              "move-node-to-workspace 3"
            ];
          }
          {
            "if" = {
              app-id = "jp.naver.line.mac";
            };
            run = [
              "move-node-to-workspace 3"
            ];
          }
          {
            run = [
              "move-node-to-workspace 2"
            ];
          }
        ];

        exec-on-workspace-change = [
          "/bin/bash"
          "-c"
          "${lib.getExe' pkgs.sketchybar "sketchybar"} --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
        ];

        after-startup-command = [
          ''
            exec-and-forget ${
              pkgs.writeShellApplication {
                name = "aerospace-after-startup";
                runtimeInputs = [
                  pkgs.aerospace
                  pkgs.coreutils
                ];
                text = ''
                  # move all windows to workspace 1 to avoid any windows being on the wrong workspace
                  for w in $(aerospace list-windows --all --format '%{window-id}'); do
                    aerospace move-node-to-workspace --window-id "$w" 1
                  done

                  # count monitors
                  count=$(aerospace list-monitors --count)

                  # move all workspaces to the correct monitor
                  for w in $(aerospace list-workspaces --all); do
                    aerospace move-workspace-to-monitor --workspace "$w" "$((((w - 1) % count) + 1))"
                  done

                  # focus workspaces 1 through count to ensure the lowest workspaces are focused on each monitor
                  for w in $(seq 1 "$count"); do
                    aerospace workspace "$w"
                  done
                '';
              }
            }/bin/aerospace-after-startup
          ''
        ];

        key-mapping = {
          preset = "qwerty";
        };
        gaps = {
          inner = {
            horizontal = 10;
            vertical = 10;
          };
          outer = {
            left = 5;
            right = 5;
            bottom = 5;
            top = [
              { monitor.built-in = 10; }
              40
            ];
          };
        };
        mode = {
          main = {
            binding = {
              ctrl-alt-shift-1 = "workspace 1";
              ctrl-alt-shift-2 = "workspace 2";
              ctrl-alt-shift-3 = "workspace 3";
              ctrl-alt-shift-4 = "workspace 4";
              ctrl-alt-shift-5 = "workspace 5";
              ctrl-alt-shift-6 = "workspace 6";
              ctrl-alt-shift-7 = "workspace 7";
              ctrl-alt-shift-8 = "workspace 8";
              ctrl-alt-shift-9 = "workspace 9";

              cmd-ctrl-alt-shift-1 = "move-node-to-workspace --focus-follows-window 1";
              cmd-ctrl-alt-shift-2 = "move-node-to-workspace --focus-follows-window 2";
              cmd-ctrl-alt-shift-3 = "move-node-to-workspace --focus-follows-window 3";
              cmd-ctrl-alt-shift-4 = "move-node-to-workspace --focus-follows-window 4";
              cmd-ctrl-alt-shift-5 = "move-node-to-workspace --focus-follows-window 5";
              cmd-ctrl-alt-shift-6 = "move-node-to-workspace --focus-follows-window 6";
              cmd-ctrl-alt-shift-7 = "move-node-to-workspace --focus-follows-window 7";
              cmd-ctrl-alt-shift-8 = "move-node-to-workspace --focus-follows-window 8";
              cmd-ctrl-alt-shift-9 = "move-node-to-workspace --focus-follows-window 9";

              ctrl-alt-shift-t = "layout tiles accordion";

              ctrl-alt-shift-h = "focus left";
              ctrl-alt-shift-j = "focus down";
              ctrl-alt-shift-k = "focus up";
              ctrl-alt-shift-l = "focus right";
              cmd-ctrl-alt-shift-h = "move left";
              cmd-ctrl-alt-shift-j = "move down";
              cmd-ctrl-alt-shift-k = "move up";
              cmd-ctrl-alt-shift-l = "move right";
              ctrl-alt-shift-f = "fullscreen";
            };
          };
        };
      };
    };
  };
}
