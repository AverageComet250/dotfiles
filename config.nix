# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "erzatz"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."comet" = {
    isNormalUser = true;
    description = "Shravan Mandava";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;

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

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    zsh-powerlevel10k
    librewolf
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
    tree-sitter
    ripgrep
    fzf
    wget

    fastfetch
    macchina
    hyfetch
  ];


  # TODO: manage above services using nix
  # First, these need to be managed using systemd
  # hyprlock, hyrpidle, waybar, zsh, editor

  programs.nano.enable = false;

  programs.zsh.enable = true;
  programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme; [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh ";

  programs.git.enable = true;

  programs.niri.enable = true;
  # programs.waybar.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      iosevka
    ];
  };

  programs.sway = {
    enable = false;
    extraPackages = with pkgs; [
      brightnessctl
      kitty
      grim
      pulseaudio
      swayidle
      swaylock
      wmenu
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time";
        user= "greeter";
      };
    };
  };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
