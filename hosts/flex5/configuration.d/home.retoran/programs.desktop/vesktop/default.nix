{ pkgs, ... }: {
  programs.vesktop = {
    settings = {
      discordBranch = "stable";
      minimizeToTray = true;
      arRPC = true;
      spellCheckLanguages = [
        "en-GB"
        "en"
      ];
      hardwareAcceleration = true;
    };
    vencord = {
      settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        enabledThemes = [
          "HorizontalServerList.css"
          "SkeuoCord.css"
        ];
        plugins = [];
      };
      # Should set themes in this list AND enabledthemes with same list, it's dumb there are two lists.
      themes = {
        "HorizontalServerList" = ./config/themes/HorizontalServerList.theme.css;
        "SkeuoCord" = ./config/themes/SkeuoCord.theme.css;
      };
    };
    enable = true;
  };
}
