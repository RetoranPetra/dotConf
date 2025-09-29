{ pkgs, ... }:
{
  i18n.inputMethod = {
    type = "fcitx5";
    package = pkgs.fcitx5;
    fcitx5 = {
      addons = with pkgs; [ fcitx5-mozc ];
      settings = {
        globalOptions = {
          Hotkey = {
            EnumerateWithTriggerKeys = false;
            ModifierOnlyKeyTimeout = 250;
            TriggerKeys = {
              "0" = "Control+Alt+space";
              "1" = "Zenkaku_Hankaku";
              "2" = "Hangul";
            };
            ActivateKeys = { "0" = "Control+grave"; };
            DeactivateKeys = { "0" = "Control-notsign"; };
          };
        };
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "gb";
            DefaultIM = "mozc";
          };
          "Groups/0/Items/0".Name = "keyboard-gb";
          "Groups/0/Items/1".Name = "mozc";
        };
      };
    };
  };
}
