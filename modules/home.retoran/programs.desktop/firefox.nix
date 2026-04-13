{ pkgs, ... }:
{
  # WIP for firefox configuration
  programs.firefox = {
    # enable = false;
    languagePacks = [
      "en-GB"
      "en-US"
    ];
    profiles.retoran = {
      # Use betterfox user.js
      preConfig = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/yokoffing/Betterfox/refs/heads/main/user.js";
      };
      packages = [ ];
      extensions = {
        settings = {
          "firemonkey@eros.man.xpi".settings = { };
          "jetpack-extension@dashlane.com.xpi".settings = { };
          "marcoagpinto@mail.telepac.pt.xpi".settings = { };
          "moz-addon-prod@7tv.app.xpi".settings = { };
          "ublock@raymondhill.net.xpi".settings = { };
          "firemonkey@eros.man.xpi".settings = { };
        };
      };
    };
  };

  home.packages = with pkgs; [
    firefox
  ];
}
