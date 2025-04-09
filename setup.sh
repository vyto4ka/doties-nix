#!/usr/bin/env bash

if [[ "$EUID" -ne 0 ]]; then
  exec sudo "$0" "$@"
fi

USER_NAME="vyto4ka"
USER_HOME="/home/$USER_NAME"
HOME_MANAGER_DIR="$USER_HOME/.config/home-manager"

echo "Step 1: Copying configuration.nix to /etc/nixos"
cp -v ./configuration.nix /etc/nixos/

echo "Step 2: Copying home.nix to $HOME_MANAGER_DIR"
mkdir -p "$HOME_MANAGER_DIR"
cp -v ./home.nix "$HOME_MANAGER_DIR/"
chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.config"

echo "Step 3: Adding home-manager channel"
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager 2>/dev/null || true
nix-channel --update

echo "Step 4: Running nixos-rebuild switch"
nixos-rebuild switch
