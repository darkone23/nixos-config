#!/bin/sh

# need to use nodejs 14 because of node2nix bug with newer npm versions
# can follow along here:
# https://github.com/nix-community/npmlock2nix/issues/153

node2nix -i node-packages.json --nodejs-14