{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
      ];
      # Likely don't need all these settings set, but copying .dotConf one for one until I know what I'm doing.
      settings = {
        globalOptions = {
          Hotkey = {
            EnumerateWithTriggerKeys = false;
            AltTriggerKeys = "";
            EnumerateForwardKeys = "";
            EnumerateBackwardKeys = "";
            EnumerateGroupForwardKeys = "";
            EnumerateGroupBackwardKeys = "";
            EnumerateSkipFirst = false;
            ModifierOnlyKeyTimeout = 250;
          };
          "Hotkey/TriggerKeys" = {
            "0" = "Control+Alt+space";
            "1" = "Zenkaku_Hankaku";
            "2" = "Hangul";
          };
          "Hotkey/ActivateKeys"."0" = "Control+grave";
          "Hotkey/DeactivateKeys"."0" = "Control+notsign";
          "Hotkey/PrevPage"."0" = "Up";
          "Hotkey/NextPage"."0" = "Down";
          "Hotkey/PrevCandidate"."0" = "Shift+Tab";
          "Hotkey/NextCandidate"."0" = "Tab";
          Behavior = {
            ActiveByDefault = false;
            resetStateWhenFocusIn = false;
            ShareInputState = false;
            PreeditEnabledByDefault = true;
            ShowInputMethodInformation = true;
            ShowFirstInputMethodInformation = true;
            DefaultPageSize = 5;
            OverrideXkbOption = false;
            CustomXkbOption = "caps:escape";
            EnabledAddons = "";
            DisabledAddons = "";
            PreloadInputMethod = true;
            AllowInputMethodForPassword = false;
            ShowPreeditForPassword = false;
            AutoSavePeriod = 30;
          };
        };
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "gb";
            DefaultIM = "mozc";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-gb";
            Layout = "";
          };
          "Groups/0/Items/1" = {
            Name = "mozc";
            Layout = "gb";
          };
        };
      };
    };
  };
}
