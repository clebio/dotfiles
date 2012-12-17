#Caleb's Dotfiles

## Move all dot-files to un-dotted filenames
    find . -name '.*' | sed -r 's/\.\/(\.(.+))/mv \1 \2/g' | sh
