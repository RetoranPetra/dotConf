{ pkgs, lib, ... }: {
  home.packages = [
    pkgs.gallery-dl
    pkgs.czkawka-full
  ];
  xdg.configFile."gallery-dl/config.json".source = ./config.json;
  xdg.configFile."gallery-dl/giftomp4.bash".source = ./giftomp4.bash;
  programs.zsh.initContent = lib.mkOrder 1500 ''
    gallery-dl-redditu() {
      for user in "$@"
      do
        gallery-dl "reddit.com/search/?q=author%3A$user&include_over_18=on&sort=new" -o skip=abort
      done
    }
    gallery-dl-twitteru() {
      for user in "$@"
      do
        gallery-dl "x.com/$user" -o skip=abort
      done
    }
  '';
}
