#!/bin/zsh
if where gem > /dev/null; then
	export GEM_HOME="$(gem env user_gemhome)"
	export PATH="$PATH:$GEM_HOME/bin"
fi
