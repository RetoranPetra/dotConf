#!/bin/zsh
for f in $PWD/**/*.sh; do;
  sed -ir "s/\/bash$/\/zsh/" $f
  sed -ir "s/\/sh$/\/zsh/" $f
  sed -ir "s/sh /zsh /" $f
  mv $f ${f%.*}.zsh
done
