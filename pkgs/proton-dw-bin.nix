{
  lib,
  fetchzip,
  stdenvNoCC,
}:
# TODO: This should build from the latest release automatically at some point.
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "proton-dw-bin";
  version = "10.0-26";
  src = fetchzip {
    url = "https://dawn.wine/dawn-winery/dwproton/releases/download/dwproton-${finalAttrs.version}/dwproton-${finalAttrs.version}-x86_64.tar.xz";
    hash = "sha256-TkwhJCHPS0PdDIEL5GrxJPR09uO9U2DR8l9KWFLIF2g=";
  };
  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  outputs = [
    "out"
    "steamcompattool"
  ];
  installPhase = ''
    runHook preInstall

    # Make it impossible to add to an environment. You should use the appropriate NixOS option.
    # Also leave some breadcrumbs in the file.
    echo "${finalAttrs.pname} should not be installed into environments. Please use programs.steam.extraCompatPackages instead." > $out

    mkdir $steamcompattool
    ln -s $src/* $steamcompattool
    rm $steamcompattool/compatibilitytool.vdf
    cp $src/compatibilitytool.vdf $steamcompattool

    runHook postInstall
  '';
  # Remove specific version from string so don't need to reselect tool every time in steam.
  preFixup = ''
    sed -i -E 's/"dwproton-[^"]*"/"dwproton"/g' $steamcompattool/compatibilitytool.vdf
  '';
  meta = with lib; {
    description = ''
      DW-Proton compatibility layer.

      (This is intended for use in the `programs.steam.extraCompatPackages` option only.)
    '';
    homepage = "https://dawn.wine/";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
})
