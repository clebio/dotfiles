#!/bin/bash
export DOTFILE_DIR=dotfiles

# Rename existing dot files that we track from ${HOME} to a '.bak' copy
find ./ -name '_*' \
    -exec bash -c 'find ${HOME}/ -maxdepth 1 -name "${1/\.\/\_/.}" \
    | xargs -I'{}' mv {} {}.bak' -- {} \;

# Symlink underscored files in DOTFILE_DIR to HOME/.<filename>
find ./ -name '_*' \
    -exec bash -c 'ln -s ${HOME}/${DOTFILE_DIR}/${1/\.\//} ${HOME}/${1/\.\/\_/\.}' -- {} \;

unset DOTFILE_DIR
