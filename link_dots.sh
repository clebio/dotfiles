#!/bin/bash
export DOTFILE_DIR=dotfiles

# Rename existing dot files that we track from ${HOME} to a '.bak' copy
find ./ -maxdepth 1 -name '_*' \
    -exec bash -c 'find "${HOME}/" -name "${1/\.\/\_/.}" -type l \
    | xargs -I'{}' rm {}' -- {} \;

# Symlink underscored files in DOTFILE_DIR to HOME/.<filename>
find ./ -maxdepth 1 -name '_*' \
    -exec bash -c 'ln -s ${HOME}/${DOTFILE_DIR}/${1/\.\//} ${HOME}/${1/\.\/\_/\.}' -- {} \;

# link ${HOME}/bin
if ! [ -e ${HOME}/bin ]
then
    mkdir ${HOME}/bin
fi

find ./bin/ -maxdepth 1 -name '*sh' \
    -exec bash -c 'ln -s ${HOME}/${DOTFILE_DIR}/${1/\.\//} ${HOME}/${1/\.\//}' -- {} \;

unset DOTFILE_DIR
