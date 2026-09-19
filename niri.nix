{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kitty
    waybar
    mako
    awww
    rofi
    hyprlock
    hypridle
    hyprpolkitagent # wasn't sure which pkg for polkit-kde-agent
    wl-clipboard
    bibata-cursors
    brightnessctl
  ];

  # TODO: manage above services using nix
  # First, these need to be managed using systemd
  # hyprlock, hyrpidle, waybar, zsh, editor

  # TODO: terminal emulator in its own file?

  programs.niri.enable = true;
  # programs.waybar.enable = true;
}
