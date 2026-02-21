.PHONY: install
install:
	curl -sSf -L https://install.lix.systems/lix | sh -s -- install

.PHONY: rebuild
rebuild:
	sudo /nix/var/nix/profiles/default/bin/nix run nix-darwin -- switch --flake .#mac

# OLD:

.PHONY: brew
brew:
	brew update
	brew upgrade
	brew bundle --cleanup

.PHONY: stow_check
stow_check:
	stow --simulate -v -t $$HOME .

.PHONY: stow
stow:
	stow -v -t $$HOME .
