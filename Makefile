.PHONY: install
install:
	# TODO: replace branch name (experimental/nix → master) once merged
	curl -sSf -L https://raw.githubusercontent.com/evgkirov/dotfiles/refs/heads/experimental/nix/install.sh | sh -s --

.PHONY: build
build:
	sudo darwin-rebuild switch --flake .#mac

.PHONY: upgrade
upgrade:
	nix flake update --commit-lock-file
	$(MAKE) build

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
