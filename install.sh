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

TEMP_INSTALL_PATH=${HOME}
CFG_PATH=${TEMP_INSTALL_PATH}/mac-config
VIM_PATH=${CFG_PATH}/vim

echo -e "$INFO_CLR-------------------- Downloading Mac-config --------------------$RESET_CLR"

cd "${TEMP_INSTALL_PATH}"
rm -rf "${CFG_PATH}"

git clone git@github.com:ddrccw/mac-config.git

echo -e "$RESULT_CLR-------------------- Download Mac-config --------------------$RESET_CLR"

echo -e "$INFO_CLR-------------------- Downloading Submodule --------------------$RESET_CLR"

cd "${CFG_PATH}"
git submodule init
git submodule update 


cd "${VIM_PATH}"
git submodule init
git submodule update

echo -e "$RESULT_CLR-------------------- Download Submodule --------------------$RESET_CLR"

echo -e "$INFO_CLR-------------------- Making Symbolic Links --------------------$RESET_CLR"

rm -rf ${HOME}/.vimrc
rm -rf ${HOME}/.vim
rm -rf ${HOME}/.tmux.conf
rm -rf ${HOME}/.tmux
rm -rf ${HOME}/.gitconfig
rm -rf ${HOME}/.lldbinit
rm -rf ${HOME}/.aria2
rm -rf ${HOME}/.zshrc
rm -rf ${HOME}/.pip/pip.conf

#vim
ln -s ${VIM_PATH}/.vimrc ${HOME}/.vimrc
ln -s ${VIM_PATH}/.vim ${HOME}/

#tmux
ln -s ${CFG_PATH}/.tmux.conf ${HOME}/.tmux.conf
ln -s ${CFG_PATH}/.tmux ${HOME}/

#others
ln -s ${CFG_PATH}/.gitconfig ${HOME}/.gitconfig
ln -s ${CFG_PATH}/.gitignore_global ${HOME}/.gitignore_global
ln -s ${CFG_PATH}/.lldbinit ${HOME}/.lldbinit
ln -s ${CFG_PATH}/.aria2 ${HOME}/
ln -s ${CFG_PATH}/.zshrc ${HOME}/.zshrc
ln -s ${CFG_PATH}/pip.conf ${HOME}/.pip/pip.conf

echo -e "$RESULT_CLR-------------------- Make Symbolic Links  --------------------$RESET_CLR"

echo -e "$INFO_CLR-------------------- Installing Tmux Plugins --------------------$RESET_CLR"

${HOME}/.tmux/plugins/tpm/bin/install_plugins
tmux source-file ${HOME}/.tmux.conf

echo -e "$RESULT_CLR-------------------- Install Symbolic Links  --------------------$RESET_CLR"

echo -e "$INFO_CLR-------------------- Installing Vim Plugins --------------------$RESET_CLR"

vim +PluginInstall +qall < /dev/tty

echo -e "$RESULT_CLR-------------------- Install Vim Plugins  --------------------$RESET_CLR"

