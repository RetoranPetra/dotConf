{
  fetchurl,
  vintagestory,
  lib,
  dotnet-runtime_10,
}:
let
  version = "1.22.2";
in
vintagestory.overrideAttrs {
  version = version;
  src = fetchurl {
    url = "https://cdn.vintagestory.at/gamefiles/stable/vs_client_linux-x64_${version}.tar.gz";
    hash = "sha256-caLSOm/WXpXrjC1az72Nc0XDWOpWB2R9iVq8ShDEZgU=";
  };
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/vintagestory $out/bin $out/share/icons/hicolor/512x512/apps $out/share/fonts/truetype
    cp -r * $out/share/vintagestory

    # Old way
    #magick $out/share/vintagestory/assets/gameicon.xpm $out/share/icons/hicolor/512x512/apps/vintagestory.png
    cp $out/share/vintagestory/assets/gameicon.png $out/share/icons/hicolor/512x512/apps/vintagestory.png
    cp $out/share/vintagestory/assets/game/fonts/*.ttf $out/share/fonts/truetype

    rm -rvf $out/share/vintagestory/{install,run,server}.sh

    runHook postInstall
  '';
  preFixup = ''
     makeWrapperArgs+=(--prefix LD_LIBRARY_PATH : "$runtimeLibraryPath")

     makeWrapper ${lib.meta.getExe dotnet-runtime_10} $out/bin/vintagestory \
      "''${makeWrapperArgs[@]}" \
       --add-flags $out/share/vintagestory/Vintagestory.dll

    makeWrapper ${lib.getExe dotnet-runtime_10} $out/bin/vintagestory-server \
      "''${makeWrapperArgs[@]}" \
      --add-flags $out/share/vintagestory/VintagestoryServer.dll

     find "$out/share/vintagestory/assets/" -not -path "*/fonts/*" -regex ".*/.*[A-Z].*" | while read -r file; do
       local filename="$(basename -- "$file")"
       ln -sf "$filename" "''${file%/*}"/"''${filename,,}"
     done
  '';
}
