#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# zsh
ZSHDIR=~/.zshrc
if ! [ -L $ZSHDIR ]; then
  ln -s ${BASEDIR}/.zshrc $ZSHDIR
else
  echo $ZSHDIR "symlink already exists"
fi

# i3
I3DIR=~/.config/i3
if ! [ -L $I3DIR ]; then
  ln -s ${BASEDIR}/i3/ $I3DIR
else
  echo $I3DIR "symlink already exists"
fi

# tmuxinator
TMUXDIR=~/.config/tmuxinator
if ! [ -L $TMUXDIR ]; then
  ln -s ${BASEDIR}/tmuxinator/ $TMUXDIR
else
  echo $TMUXDIR "symlink already exists"
fi

# rofi
ROFIDIR=~/.config/rofi
if ! [ -L $ROFIDIR ]; then
  ln -s ${BASEDIR}/rofi/ $ROFIDIR
else
  echo $ROFIDIR "symlink already exists"
fi

# git
GITDIR=~/.gitconfig
if ! [ -L $GITDIR ]; then
  ln -s ${BASEDIR}/.gitconfig $GITDIR
else
  echo $GITDIR "symlink already exists"
fi

# copyq
COPYQDIR=~/.config/copyq
if ! [ -d $COPYQDIR ]; then
  ln -s ${BASEDIR}/copyq/ $COPYQDIR
else
  echo $COPYQDIR "symlink already exists"
fi
