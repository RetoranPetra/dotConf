{ pkgs, ... }:
{
  services.arrpc.enable = true;
  programs.vesktop = {
    # Enabling middle click scroll doesn't disable middle click paste because they hate me.
    package = pkgs.vesktop.override { withMiddleClickScroll = true; };
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
          #"SkeuoCord.css"
        ];
        plugins = {
          BetterGifPicker.enabled = true;
          "WebRichPresence (arRPC)".enabled = true;
          MessageLogger = {
            enabled = true;

            collapseDeleted = false;

            deleteStyle = "text";

            ignoreBots = false;
            ignoreSelf = false;

            logEdits = true;
            logDeletes = true;
            inlineEdits = true;
          };

          TypingIndicator = {
            enabled = true;
            includeCurrentChannel = true;
            indicatorMode = 3;
          };
          TypingTweaks = {
            enabled = true;
            alternativeFormatting = true;
            showRoleColors = true;
            showAvatars = true;
          };

          # TODO: Add custom vesktop plugins.
        };
      };
      # Should set themes in this list AND enabledthemes with same list, it's dumb there are two lists.
      themes = {
        "HorizontalServerList" = ./config/themes/HorizontalServerList.theme.css;
        #"SkeuoCord" = ./config/themes/SkeuoCord.theme.css;
      };
    };
    enable = true;
  };
}
