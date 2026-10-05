{
  pkgs,
  lib,
  config,
  ...
}:
let
  handlr-regex-xdg-open = pkgs.writeTextFile {
    name = "handlr-regex-xdg-open";
    executable = true;
    destination = "/bin/xdg-open";
    text = ''
      #!/usr/bin/env bash
      ${pkgs.handlr-regex}/bin/handlr open "$@"
    '';
  };
in
{
  options.retoran.desktop.handlr.enable = lib.mkDefault true;
  config = lib.mkIf config.retoran.desktop.hanldr.enable {
    home.packages = [
      pkgs.handlr-regex
      handlr-regex-xdg-open
    ];

  };
}
