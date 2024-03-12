# Lines configured by zsh-newuser-install
HISTFILE=~/.zshhistory
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
#
source ~/antigen.zsh

antigen use oh-my-zsh

# Required plugins for themes to work
#
#antigen bundle git
antigen bundle gitfast
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
# end

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Experimental zsh completion scripts
antigen bundle zsh-users/zsh-completions

# Notifications for long running commands
antigen bundle bgnotify

# Added copy commands
antigen bundle copypath # Copies file path
antigen bundle copyfile # Copies file contents
antigen bundle copybuffer # Copies current commandline buffer

# fzf integration
antigen bundle fzf
antigen bundle fd

# Github CLI integration
antigen bundle gh

# gitignore.io integration, use gi list to list templates, gi template to display template.
antigen bundle gitignore

# git-prompt
# Not integrating with theme.
#antigen bundle git-prompt

# Language completion/themes

# Golang comp and aliases
antigen bundle golang
# Rust comp
antigen bundle rust
# Completion and aliases for dotnet
antigen bundle dotnet

# Fastfile, may be useful. Need to set fastfile prefix if going to use.
#antigen bundle fastfile


# May be useful, dotenv. Loads .env file when you cd into the root dir.
#antigen bundle dotenv

# Vi-mode, not quite intuitive.
# Need to configure it further before enabling
#https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode

#antigen bundle vi-mode

# Interactive cd, needs to be sourced as script not as plugin.
# Replaces tab completion on cd to fzf.
#source ~/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

antigen theme af-magic

antigen apply

source ~/.bashalias

source desk
