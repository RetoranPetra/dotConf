{ ... }: {
  services.pipewire.enable = true;
  services.pipewire.clientConfigs = {
    "10-block-volume-control" = {
      "pulse.rules" = [
        {
          matches = [
            { "application.name" = "~Chromium.*"; }
          ];
          actions.quirks = "block-source-volume";
        }
        {
          matches = [
            { "application.name" = "~^vesktop$"; }
          ];
          actions.quirks = "block-source-volume";
        }
      ];
    };
  };
}
