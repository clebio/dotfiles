#!/bin/bash
find ./ -name '_*' -exec bash -c 'ln -s ${HOME}/dotfiles/${1/\.\//} ${HOME}/${1/\.\/\_/\.}' -- {} \;
