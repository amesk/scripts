#!/bin/sh
git config --global user.name amesk
git config --global user.email alexei.eskenazi@transas.com
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.unstage 'reset HEAD --'
git config --global core.editor "emacs -nw"
git config --global merge.tool meld

