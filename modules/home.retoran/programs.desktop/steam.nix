{ pkgs, ... }:
let
  compatTools = [
    pkgs.steamtinkerlaunch
    pkgs.proton-ge-bin
    pkgs.proton-dw-bin
  ];
in
{
  home.file = (
    builtins.listToAttrs (
      map (compatTool: {
        name = ".local/share/Steam/compatibilitytools.d/${compatTool.pname}";
        value = {
          source = compatTool.steamcompattool;
        };
      }) compatTools
    )
  );
  # Think I need to run "steamtinkerlaunch p list" after updating the compat tools for everything to behave.

  # Add steamtinkerlaunch to path
  home.packages = [ pkgs.steamtinkerlaunch ];
}
