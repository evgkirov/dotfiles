#!/bin/sh

curl -sSf -L https://install.lix.systems/lix | sh -s -- install

# TODO: replace branch name (experimental/nix → master) once merged
sudo /nix/var/nix/profiles/default/bin/nix run nix-darwin -- switch --flake github:evgkirov/dotfiles/experimental/nix#mac
