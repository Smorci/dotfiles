#!/bin/sh
sudo nix-channel --update
pushd ~/.dotfiles
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd
