{
  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      # keep-sorted start
      "1password"
      "domzilla-caffeine"
      "ghostty"
      "google-chrome"
      "karabiner-elements"
      "microsoft-edge"
      "raycast"
      "slack"
      "visual-studio-code"
      "zoom"
      # keep-sorted end
    ];
    masApps = {
      # keep-sorted start
      "辞書 by 物書堂" = 1380563956;
      DaisyDisk = 411643860;
      GoodLinks = 1474335294;
      Pastebot = 1179623856;
      # keep-sorted end
    };
    onActivation = {
      cleanup = "zap";
    };
  };
}
