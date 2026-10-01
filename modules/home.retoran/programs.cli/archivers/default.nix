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
    gallery-dl.enable = lib.mkDefault true;
    enable = lib.mkDefault true;
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."yt-dlp.conf".source = ./yt-dlp.conf;
    home.packages = with pkgs; [
      yt-dlp
      patreon-dl
    ];
    gallery-dl = lib.mkIf cfg.gallery-dl.enable import ./default.nix;
  };
}
