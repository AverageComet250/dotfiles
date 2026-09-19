
{ config, lib, pkgs, modulesPath, ... }:
{
  users.users."comet" = {
    isNormalUser = true;
    description = "Shravan Mandava";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  hjem.users.comet = {
    files = {
      ".zshrc".source = ./.zshrc;
      ".p10k.zsh".source = ./.p10k.zsh;
      ".config/hyfetch.json".source = ./.config/hyfetch.json;
      ".config/hyfetch-mini.json".source = ./.config/hyfetch-mini.json;
      ".config/hyfetch-mini.art".source = ./.config/hyfetch-mini.art;
      ".config/macchina/macchina.toml".source = ./.config/macchina/macchina.toml;
      ".config/niri".source = ./.config/niri;
      ".config/waybar".source = ./.config/waybar;
      ".config/rofi".source = ./.config/rofi;
      ".config/hypr".source = ./.config/hypr;
      ".config/walls".source = ./.config/walls;
      ".config/kitty".source = ./.config/kitty;
      ".config/nvim/lua".source = ./.config/nvim/lua;
      ".config/nvim/init.lua".source = ./.config/nvim/init.lua;
    };
  };
}
