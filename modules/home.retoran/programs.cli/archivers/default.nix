{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.retoran.programs-cli.archivers;
in
{
  options.retoran.programs-cli.archivers = {
    gallery-dl.enable = lib.mkEnableOption "";
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        xdg.configFile."yt-dlp.conf".source = ./yt-dlp.conf;
        home.packages = with pkgs; [
          yt-dlp
          patreon-dl
        ];
      }
      (lib.mkIf cfg.gallery-dl.enable (import ./default.nix))
    ]
  );
}
