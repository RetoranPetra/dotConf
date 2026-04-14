{ pkgs, ... }:
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
  home.packages = [
    pkgs.handlr-regex
    handlr-regex-xdg-open
  ];
}
