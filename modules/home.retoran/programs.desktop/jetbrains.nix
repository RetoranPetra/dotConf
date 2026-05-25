{
  pkgs,
  lib,
  ...
}:
{
  home.packages = [
    pkgs.jetbrains.rider
  ];
  # Some sensible defaults when we're not launching from the command line.
  # This is done in a bit of a stupid awful way but I'm not looking at this anymore.
  home.file.".local/share/applications/rider.desktop".source = (
    pkgs.stdenv.mkDerivation {
      name = "rider-default-desktop";
      phases = ["buildPhase"];
      buildPhase = ''
        substitute ${pkgs.jetbrains.rider}/share/applications/rider.desktop $out \
          --replace-fail "Exec=rider" "Exec=${
            (pkgs.writeShellApplication {
              name = "rider-default-runtime";
              runtimeInputs = [
                pkgs.jetbrains.rider
                (
                  with pkgs.dotnetCorePackages;
                  combinePackages [
                    dotnet_10.sdk
                    dotnet_10.aspnetcore
                    dotnet_10.runtime
                    dotnet_10.vmr
                  ]
                )
              ];
              text = "rider \"$@\"";
            })
          }/bin/rider-default-runtime"
      '';
    }
  );
}
