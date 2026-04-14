{
  config,
  lib,
  pkgs,
  ...
}:
let
  # TODO: This should build from the latest release automatically at some point.
  proton-dw-bin = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "proton-dw-bin";
    version = "10.0-23";
    src = pkgs.fetchzip {
      url = "https://dawn.wine/dawn-winery/dwproton/releases/download/dwproton-${finalAttrs.version}/dwproton-${finalAttrs.version}-x86_64.tar.xz";
      hash = "sha256-XqXXxsTekvTUNsykpWu4vbZ4Mi+2tMR57zngaOt+3gQ=";
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
  });
in
{

  users.users.retoran = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "openrazer"
    ];
    shell = pkgs.zsh;
  };
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      proton-dw-bin
    ];
    protontricks.enable = true;
  };
  programs.gamescope.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka
  ];
  security.polkit.enable = true;
}
