#!/bin/sh

sudo nixos-rebuild -I nixos-config="$HOME/nix/configuration.nix" switch
