#!/bin/sh
pushd ~/.dotfiles
sudo nixos-rebuild \t\e\s\t -I nixos-config=./system/configuration.nix
popd