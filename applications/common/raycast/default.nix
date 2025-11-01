{ pkgs, lib, ... }:
{
  xdg.configFile = {
    "raycast/aerospace-relocate-workspaces.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = pkgs.writeShellScript "aerospace-relocate-workspaces" ''
        # Required parameters:
        # @raycast.schemaVersion 1
        # @raycast.title Aerospace Relocate Workspaces
        # @raycast.mode compact

        # Optional parameters:
        # @raycast.icon 🤖

        # Documentation:
        # @raycast.description Relocate all workspaces to the correct monitor

        # count monitors
        count=$(${lib.getExe' pkgs.aerospace "aerospace"} list-monitors --count)

        # move all workspaces to the correct monitor
        for w in $(${lib.getExe' pkgs.aerospace "aerospace"} list-workspaces --all); do
          ${lib.getExe' pkgs.aerospace "aerospace"} move-workspace-to-monitor --workspace "$w" "$((((w - 1) % count) + 1))"
        done
      '';
    };
  };
}
