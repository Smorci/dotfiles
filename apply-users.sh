#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/marci/home.nix
popd
