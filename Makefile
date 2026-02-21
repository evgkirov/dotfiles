.PHONY: install
install:
	# TODO: replace branch name (experimental/nix → master) once merged
	curl -sSf -L https://raw.githubusercontent.com/evgkirov/dotfiles/refs/heads/experimental/nix/install.sh | sh -s --

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
