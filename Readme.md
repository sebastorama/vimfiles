# Building Vim!

Mostly copied from https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

## Install dependencies

```
sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git
```

## Uninstall any trace of vim

`
sudo apt remove vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox
`

## Get vim source
`git clone https://github.com/vim/vim.git`

## Jump to the vim directory and then fire the .configure script with this ton of flags
```
./configure --with-features=huge \
            --enable-multibyte \
	    --enable-rubyinterp=yes \
	    --enable-pythoninterp=yes \
	    --with-python-config-dir=/usr/lib/python2.7/config \
	    --enable-python3interp=yes \
	    --with-python3-config-dir=/usr/lib/python3.5/config \
	    --enable-perlinterp=yes \
	    --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
	   --prefix=/usr/local
```

## Good old make..

` make && sudo make install `

## Check if you have what you want:
`vim --version`

## Next Steps:

```
1 - git clone https://github.com/sebastorama/vimfiles.git ~/.vim
2 - ln -s ~/.vim/vimrc ~/.vimrc
4 - git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
5 - Open vim and call "PluginInstall"
6 - Compile the command-t extension ( see *command-t-compile* https://github.com/wincent/Command-T )
7 - You'll be good to go (probably...)
```
