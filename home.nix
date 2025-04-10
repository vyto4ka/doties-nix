{ config, pkgs, ... }:

{
  home.username = "vyto4ka";
  home.homeDirectory = "/home/vyto4ka";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    nekoray
    firefox
    git
    neovim
    kitty
    lua
    tree
    gcc
    clang
    zig
  ];

  programs.git.enable = true;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "colored-man-pages" ];
    };
  };
}
