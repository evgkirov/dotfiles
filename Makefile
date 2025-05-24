.PHONY: brew stow stow_check

brew:
	brew bundle --cleanup
	brew upgrade

stow_check:
	stow --simulate -v -t $$HOME .

stow:
	stow -v -t $$HOME .
