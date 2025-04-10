#!/usr/bin/env bash
#нафиг разнообразие и гибкость, делаю для себя
if [[ "$EUID" -ne 0 ]]; then
  exec sudo "$0" "$@"
fi

echo "Step 1: Copying configuration.nix to /etc/nixos"
cp -v ./configuration.nix /etc/nixos/

echo "Step 2: Copying home.nix to /home/vyto4ka/.config/home-manager"
mkdir -p /home/vyto4ka/.config/home-manager
cp -v ./home.nix /home/vyto4ka/.config/home-manager/
chown -R vyto4ka:vyto4ka /home/vyto4ka/.config

echo "Step 3: Adding home-manager channel"
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager 2>/dev/null || true
nix-channel --update

echo "Step 4: Running nixos-rebuild switch"
nixos-rebuild switch

echo "Step 5: Installing LazyVim config"
sudo -u vyto4ka git clone https://github.com/LazyVim/starter /home/vyto4ka/.config/nvim
rm -rf /home/vyto4ka/.config/nvim/.git
