#!/bin/sh
pushd ~/.dotfiles
home-manager -b bck \t\e\s\t -f ./users/marci/home.nix
popd
