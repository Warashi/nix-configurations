{ pkgs, ... }:
let
  ghostty-mock = pkgs.writeShellScriptBin "ghostty-mock" "true";
in
{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then ghostty-mock else pkgs.ghostty;
    installBatSyntax = false;
    enableFishIntegration = true;
    clearDefaultKeybinds = false;
    settings = {
      theme = "catppuccin-frappe";
      font-size = 13;
      font-family = "Moralerspace Radon";
      shell-integration = "none";
      working-directory = "home";
      window-inherit-working-directory = false;
      macos-option-as-alt = true;
      macos-titlebar-style = "hidden";
      keybind = [
        "shift+enter=text:\\n"
      ];
    };
  };
}
