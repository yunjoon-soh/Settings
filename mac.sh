#!/bin/sh

# Installing vim
echo "Installing vim..."

if [ -e ~/.vimrc ]; then
		echo "############################################################" >> ~/.saved_vimrc
		cat ~/.vimrc >> ~/.saved_vimrc
		echo "#Saved by mac.sh script" >> ~/.saved_vimrc
		echo "|-Saved original vimrc"
fi

cp ./Vim/vimrc ~/.vimrc
echo "|-Copied new vimrc to .vimrc"

if [ ! -e ~/.vim ]; then
		mkdir ~/.vim
		echo "|-Created ~/.vim"
elif [ ! -d ~/.vim ]; then
		echo "[Error] ~/.vim is not a directory and exists! Abort"
else
		echo "|-Found ~/.vim folder"
fi

if [ ! -d ~/.vim/colors ]; then
		mkdir ~/.vim/colors
		echo "|-Created ~/.vim/colors folder"
else
		echo "|-Found ~/.vim/colors folder"
fi

cp ./Vim/*.vim ~/.vim/colors/
echo "|-Copied ./Vim/*.vim ~/.vim/colors/"

# Installing Bash
echo "Installing Bash..."

if [ -e ~/.bash_profile ]; then
		echo "#############################################################" >> ~/.bash_profile
		cat ./Mac_Terminal/bash_profile >> ~/.bash_profile
		echo "#Appended by mac.sh. Check https://github.com/yunjoon-soh/Settings for details." >> ~/.bash_profile
		echo "|-Appended to existing ~/.bash_profile"
else 
		cp ./Mac_Terminal/bash_profile ~/.bash_profile
		echo "|-Copied ./Mac_Terminal/bash_profile ~/.bash_profile"
fi


