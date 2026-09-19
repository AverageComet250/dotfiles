
{ config, lib, pkgs, modulesPath, root, ... }:
{
  users.users."comet" = {
    isNormalUser = true;
    description = "Shravan Mandava";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  hjem.users.comet = {
    files = {
      ".zshrc".source = "${root}/.zshrc";
      ".p10k.zsh".source = "${root}/.p10k.zsh";
      ".config/hyfetch.json".source = "${root}/.config/hyfetch.json";
      ".config/hyfetch-mini.json".source = "${root}/.config/hyfetch-mini.json";
      ".config/hyfetch-mini.art".source = "${root}/.config/hyfetch-mini.art";
      ".config/macchina/macchina.toml".source = "${root}/.config/macchina/macchina.toml";
      ".config/niri".source = "${root}/.config/niri";
      ".config/waybar".source = "${root}/.config/waybar";
      ".config/rofi".source = "${root}/.config/rofi";
      ".config/hypr".source = "${root}/.config/hypr";
      ".config/walls".source = "${root}/.config/walls";
      ".config/kitty".source = "${root}/.config/kitty";
      ".config/nvim/lua".source = "${root}/.config/nvim/lua";
      ".config/nvim/init.lua".source = "${root}/.config/nvim/init.lua";
    };
  };
}
