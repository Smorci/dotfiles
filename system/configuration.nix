# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <agenix/modules/age.nix>
    ];

	virtualisation.docker.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

	# Enable flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.settings.max-jobs = "auto";

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.hostName = "smorc"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;
   hardware.bluetooth.enable = true;

   services.blueman.enable = true;

  # Enable the X11 windowing system.
  # Enable touchpad support (enabled default in most desktopManager).
  services = {
    xserver = {
      enable = true;
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
      windowManager = {
        i3.enable = true;
	      i3.extraPackages = with pkgs; [ i3status dmenu i3lock-fancy];
      };
      displayManager = {
	      sddm.enable = true;
      };
      layout = "us,hu";
      xkbOptions = "grp:alt_shift_toggle";
      deviceSection = ''
        Option "TearFree" "true"
      '';
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marci = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    mpv
    feh
    vscodium
    xcalib
    xtermcontrol
    arandr
    wirelesstools
    docker
    nixos-option
    (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
  ];
  environment.shells = with pkgs; [ zsh ];

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      carlito
      corefonts
      fira
      fira-code
      fira-code-symbols
      fira-mono
      hasklig
      mononoki
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-code-pro
      source-sans-pro
      source-serif-pro
      terminus_font
      terminus_font_ttf
      ubuntu_font_family
      font-awesome_5
      iosevka
      powerline-fonts
    ];
  };

  nixpkgs.config.allowUnfree = true;

	programs.zsh.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

