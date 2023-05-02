bash:
	ln -sf $(PWD)/bashrc $(HOME)/.bashrc

git:
	ln -sf $(PWD)/gitconfig $(HOME)/.gitconfig

zsh:
	ln -sf $(PWD)/zshrc $(HOME)/.zshrc

alacritty:
	mkdir -p ~/.config/alacritty
	ln -sf $(PWD)/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml

vim:
	ln -sf $(PWD)/vimrc $(HOME)/.vimrc

clean:
	rm -rf ~/.config/alacritty
