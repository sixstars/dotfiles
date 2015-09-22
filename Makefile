all: clean
	ln -s ${HOME}/.dotfiles/bashrc ${HOME}/.bashrc
	ln -s ${HOME}/.dotfiles/ctfrc ${HOME}/.ctfrc
	ln -s ${HOME}/.dotfiles/git-prompt.sh ${HOME}/.git-prompt.sh
	ln -s ${HOME}/.dotfiles/gitconfig ${HOME}/.gitconfig
	ln -s ${HOME}/.dotfiles/inputrc ${HOME}/.inputrc
	ln -s ${HOME}/.dotfiles/pythonrc ${HOME}/.pythonrc
	ln -s ${HOME}/.dotfiles/tmux-osx.conf ${HOME}/.tmux-osx.conf
	ln -s ${HOME}/.dotfiles/tmux.conf ${HOME}/.tmux.conf
	ln -s ${HOME}/.dotfiles/vimrc ${HOME}/.vimrc

clean:
	rm -rf ${HOME}/.bashrc
	rm -rf ${HOME}/.ctfrc
	rm -rf ${HOME}/.git-prompt.sh
	rm -rf ${HOME}/.gitconfig
	rm -rf ${HOME}/.inputrc
	rm -rf ${HOME}/.pythonrc
	rm -rf ${HOME}/.tmux-osx.conf
	rm -rf ${HOME}/.tmux.conf
	rm -rf ${HOME}/.vimrc
