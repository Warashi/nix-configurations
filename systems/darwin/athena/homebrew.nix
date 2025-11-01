{
  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      # keep-sorted start
      "1password"
      "amazon-photos"
      "chatgpt"
      "cloudflare-warp"
      "cryptomator"
      "discord"
      "domzilla-caffeine"
      "font-biz-udgothic"
      "font-biz-udmincho"
      "font-biz-udpgothic"
      "font-biz-udpmincho"
      "ghostty"
      "google-chrome"
      "google-drive"
      "karabiner-elements"
      "lm-studio"
      "logi-options+"
      "microsoft-edge"
      "orion"
      "raycast"
      "slack"
      "tailscale-app"
      "visual-studio-code"
      "zoom"
      # keep-sorted end
    ];
    masApps = {
      # keep-sorted start
      "辞書 by 物書堂" = 1380563956;
      DaisyDisk = 411643860;
      GoodLinks = 1474335294;
      Kindle = 302584613;
      LINE = 539883307;
      Pastebot = 1179623856;
      Things = 904280696;
      # keep-sorted end
    };
    onActivation = {
      cleanup = "zap";
    };
  };
}
