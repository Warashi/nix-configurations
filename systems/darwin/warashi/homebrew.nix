{
  homebrew = {
    enable = true;
    brews = [ ];
    casks = [
      "android-studio"
      "1password"
      "chatgpt"
      "claude"
      "cryptomator"
      "cursor"
      "discord"
      "domzilla-caffeine"
      "dropbox"
      "firefox"
      "ghostty"
      "google-chrome"
      "grammarly-desktop"
      "karabiner-elements"
      "logi-options+"
      "microsoft-edge"
      "orion"
      "raycast"
      "realforce"
      "slack"
      "tailscale-app"
      "visual-studio-code"
      "zoom"
    ];
    masApps = {
      # DaisyDisk = 411643860;
      # "辞書 by 物書堂 " = 1380563956;
      # Pastebot = 1179623856;
      # TickTick = 966085870;
    };
    onActivation = {
      cleanup = "zap";
    };
  };
}
