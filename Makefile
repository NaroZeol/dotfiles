install: install-dotfiles install-tools

install-dotfiles:
	python script/install/install.py dotfiles.json backups/

install-tools:
	./script/tools/vim.sh || exit 1
	./script/tools/zsh.sh || exit 1
	exec zsh

