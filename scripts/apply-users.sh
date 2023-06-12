#!/bin/sh
pushd ~/.dotfiles
home-manager -b bck switch -f ./users/marci/home.nix
popd
