# lnEdit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "ntfs" ];
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

 # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.katsu = {
    isNormalUser = true;
    description = "katsu";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget
  neofetch
  firefox
  kitty
  w3m
  zsh
  rofi
  picom
  feh
  spotify
  neovim
  git
  python312Packages.qtile
  nemo
  lxappearance
  gnome-boxes
  pipewire
  pavucontrol
  alsa-utils
  ];
  services.xserver.enable = true;
  programs.zsh.enable = true;
    programs.zsh.ohMyZsh = {
    enable = true;
    theme = "agnoster";
    plugins = [ "git" "sudo" "docker" ];
  };
  users.defaultUserShell=pkgs.zsh; 
  services.xserver.windowManager.qtile.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
    services.picom = {
    enable = true;
    settings = {
    corner-radius = 8;
    round-borders = 1;
    backend = "glx";
  };
      # Include the path to your custom picom config here
      # ${builtins.readFile ./picom/picom.conf}
  };  
  # programs.qtile = {
  #   enable = true;
  #   extraConfig = builtins.readFile ./qtile/config.py;
  # };
  services.xserver.windowManager.qtile.configFile = ./qtile/config.py;
  environment.etc.".scripts/autostart.sh".source = ./assets/autostart.sh;
  environment.etc.".scripts/autostart.sh".mode = "0755"; # Make it executable
  environment.etc.".scripts/autostart.sh".target = "/home/katsu/.scripts/autostart.sh";
  environment.etc."Backgrounds/nordnix1.png".source = ./assets/nordnix1.png;
  environment.etc."Backgrounds/nordnix1.png".target = "/home/katsu/Backgrounds/nordnix1.png";  

  services.xserver.displayManager = {
    lightdm.enable = true;
    defaultSession = "qtile";
  };



  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
