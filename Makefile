.PHONY: brew
brew:
	brew upgrade
	brew bundle --cleanup

.PHONY: stow_check
stow_check:
	stow --simulate -v -t $$HOME .

.PHONY: stow
stow:
	stow -v -t $$HOME .
