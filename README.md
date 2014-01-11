#Caleb's Dotfiles

## Move all dot-files to un-dotted filenames
    find . -name '.*' | sed -r 's/\.\/(\.(.+))/mv \1 \2/g' | sh

## Enable Pymacs in virtualenv
### http://vikasmenon.in/2011/05/27/pymacs-helper-did-not-start-30-seconds/

ln -s /usr/lib/python2.7/dist-packages/Pymacs
ln -s /usr/lib/python2.7/dist-packages/ropemacs
ln -s /usr/lib/python2.7/dist-packages/rope
ln -s /usr/lib/python2.7/dist-packages/ropemode
