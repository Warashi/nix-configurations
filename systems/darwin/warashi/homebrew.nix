{
  homebrew = {
    enable = true;
    brews = [
      "mas"
      "mint"
    ];
    casks = [
      "1password"
      "domzilla-caffeine"
      "ghostty"
      "karabiner-elements"
      "microsoft-edge"
      "raycast"
      "tailscale-app"
    ];
    masApps = {
      DaisyDisk = 411643860;
      Pastebot = 1179623856;
      Xcode = 497799835;
    };
    onActivation = {
      cleanup = "zap";
    };
  };
}
