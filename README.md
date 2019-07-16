# vimrc
Vimrc File


## fresh install

* In the home directory, clone repo to .vim directory:
  * git clone https://github.com/Soylent17/vimconfig.git .vim
* create a symbolic linke to to the vimrc file:
  * ln -s .vim/vimrc .vimrc
* Open vim, there will be many errors. 
* vim-plug should automatically install
* if the color-scheme is not fully loaded, or you get an error about Ulti-Snips, install vim-gtk
  * apt-get remove vim
  * apt-get install vim-gtk3
