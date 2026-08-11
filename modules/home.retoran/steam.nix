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
      map
        (compatTool: {
          name = ".local/share/Steam/compatibilitytools.d/${compatTool.pname}";
          value = {
            source = compatTool.steamcompattool;
          };
        })
        [
          pkgs.steamtinkerlaunch
          pkgs.proton-ge-bin
          pkgs.proton-dw-bin
        ]
    )
  );
  # Add steamtinkerlaunch to path
  home.packages = [pkgs.steamtinkerlaunch];
}
