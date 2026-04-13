{
  programs.alacritty = {
    settings = {
      terminal.shell = "zsh";
    };
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    antidote = {
      enable = true;
      plugins = [
        "getantidote/use-omz"
        "ohmyzsh/ohmyzsh path:lib"

        "ohmyzsh/ohmyzsh path:plugins/gitfast"
        "ohmyzsh/ohmyzsh path:plugins/heroku"
        "ohmyzsh/ohmyzsh path:plugins/pip"
        #"ohmyzsh/ohmyzsh path:plugins/lein"
        "ohmyzsh/ohmyzsh path:plugins/command-not-found"

        "ohmyzsh/ohmyzsh path:plugins/fzf"
        #"ohmyzsh/ohmyzsh path:plugins/fd"

        "ohmyzsh/ohmyzsh path:plugins/gh"
        "ohmyzsh/ohmyzsh path:plugins/gitignore"
        "ohmyzsh/ohmyzsh path:plugins/golang"
        "ohmyzsh/ohmyzsh path:plugins/rust"
        "ohmyzsh/ohmyzsh path:plugins/dotnet"

        "ohmyzsh/ohmyzsh path:themes/af-magic.zsh-theme"

        #"zsh-users/zsh-syntax-highlighting"
        #"zsh-users/zsh-autosuggestions"
        #"zsh-users/zsh-completions"
      ];
    };
  };
}
