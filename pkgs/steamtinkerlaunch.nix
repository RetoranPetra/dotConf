{
  steamtinkerlaunch,
  yad,
  fetchFromGitHub
}:
# Despite the override, steamtinkerlaunch still doesn't seem to use yad 14.2.
steamtinkerlaunch.override {
  yad =
    let
      version = "14.2";
    in
    (yad.overrideAttrs {
      version = version;
      src = fetchFromGitHub {
        owner = "v1cont";
        repo = "yad";
        tag = "v${version}";
        sha256 = "sha256-6RvmPYYnotlzup6r4MAo9eqfKzrinNPwKmaYrIi2Snw=";
      };
    });
}
