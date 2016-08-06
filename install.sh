#!/bin/bash

export PATH=/opt/local/bin/:/opt/local/sbin:$PATH:/usr/local/bin:

INFO_CLR="\033[01;33m"
RESULT_CLR="\033[01;32m"
RESET_CLR="\033[0m"
ERR_CLR="\033[01;31m"

TMUX_PATH=`which tmux`

if [[ ! -f ${TMUX_PATH} || -z ${TMUX_PATH} ]]; then
	echo "WARNING: You need to install tmux first, you can use brew to simplify process:"
	echo "brew install tmux"
	exit
fi

echo -e "$INFO_CLR-------------------- Downloading Mac-config --------------------$INFO_CLR"

cd "$TEMP_INSTALL_PATH"
rm -rf "$TEMP_INSTALL_PATH"mac-config

git clone git@github.com:ddrccw/mac-config.git

echo -e "$RESULT_CLR-------------------- Download Mac-config --------------------$RESULT_CLR"

echo -e "$INFO_CLR-------------------- Downloading Submodule --------------------$INFO_CLR"

cd "$CFG_PATH"
git submodule init
git submodule update 


cd "$VIM_PATH"
git submodule init
git submodule update

echo -e "$RESULT_CLR-------------------- Download Submodule --------------------$RESULT_CLR"

echo -e "$INFO_CLR-------------------- Making Symbolic Links --------------------$INFO_CLR"

#vim
ln -s ${VIM_PATH}/.vimrc ${HOME}/.vimrc
ln -s ${VIM_PATH}/.vim ${HOME}/

#tmux
ln -s ${CFG_PATH}/.tmux.conf ${HOME}/.tmux.conf
ln -s ${CFG_PATH}/.tmux ${HOME}/

#others
ln -s ${CFG_PATH}/.gitconfig ${HOME}/.gitconfig
ln -s ${CFG_PATH}/.lldbinit ${HOME}/.lldbinit
ln -s ${CFG_PATH}/.aria2 ${HOME}/

echo -e "$RESULT_CLR-------------------- Make Symbolic Links  --------------------$RESULT_CLR"

echo -e "$INFO_CLR-------------------- Installing Tmux Plugins --------------------$INFO_CLR"

${HOME}/.tmux/plugins/tpm/bin/install_plugins

echo -e "$RESULT_CLR-------------------- Install Symbolic Links  --------------------$RESULT_CLR"

echo -e "$INFO_CLR-------------------- Installing Vim Plugins --------------------$INFO_CLR"

vim +PluginInstall +qall < /dev/tty

echo -e "$RESULT_CLR-------------------- Install Vim Plugins  --------------------$RESULT_CLR"

