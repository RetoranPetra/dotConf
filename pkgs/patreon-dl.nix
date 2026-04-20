{ pkgs }:
let
  version = "v3.8.1";
  src = pkgs.fetchFromGitHub {
    owner = "patrickkfkan";
    repo = "patreon-dl";
    rev = version;
    hash = "sha256-D0iSDAUTRc4IR0CxzG40sdHQqpkfKSlBH1qOfDZrnrA=";
  };
in
pkgs.buildNpmPackage {
  pname = "patreon-dl";
  version = version;
  npmDeps = pkgs.importNpmLock {
    npmRoot = src;
  };
  npmConfigHook = pkgs.importNpmLock.npmConfigHook;
  src = src;
  env.PUPPETEER_SKIP_DOWNLOAD = 1;
  postFixup = ''
    # Unsure if we need to wrap patreon-dl-vimeo and patreon-dl-sprout as well.
    wrapProgram $out/bin/patreon-dl \
      --set PATH ${
        pkgs.lib.makeBinPath [
          pkgs.deno
          pkgs.ffmpeg
        ]
      }
    substituteInPlace $out/lib/node_modules/patreon-dl/dist/parsers/PageParser.js \
      --replace '/<script id="__NEXT_DATA__" type="application\/json">(.+)<\/script>/gm' '/<script id="__NEXT_DATA__" type="application\/json"[^>]*>(.+)<\/script>/gm'
  '';
}
