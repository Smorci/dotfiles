# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  hardware = {
    bluetooth.enable = true;
    
    opengl.driSupport32Bit = true; # Enables support for 32bit libs that steam uses
    
    ledger.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Enable sound.
  sound.enable = false;

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Enable flakes
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = "auto";
    };
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    useDHCP = false;

    interfaces.wlp0s20f3.useDHCP = true;

    hostName = "smorci"; # Define your hostname.

    networkmanager.enable = true;
  };

  security.rtkit.enable = true;

  # Enable the X11 windowing system.
  # Enable touchpad support (enabled default in most desktopManager).
  services = {

    # Bluetooth manager
    blueman.enable = true;

    logind.extraConfig = ''
      HandlePowerKey=ignore
    '';

    # Enable the OpenSSH daemon.
    openssh.enable = true;
    
    pipewire = {
      enable = true;
      alsa = { 
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      videoDrivers = [ "intel" ];
      deviceSection = ''
        Option "TearFree" "true"
      '';
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
      windowManager = {
        i3 = {
          enable = true;
          extraPackages = with pkgs; [ i3status dmenu i3lock-fancy ];
        };
      };
      displayManager = { sddm.enable = true; };
      layout = "us,hu";
      xkbOptions = "grp:alt_shift_toggle";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.smorci = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "docker"
      "plugdev"
    ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  environment = {
    systemPackages = with pkgs; [
      pavucontrol
      vim
      wget
      git
      mpv
      xorg.xev
      feh
      vscodium
      xcalib
      xtermcontrol
      arandr
      wirelesstools
      docker
      nixos-option
      inetutils
    ];
    shells = with pkgs; [ zsh ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [ "SourceCodePro" "FiraMono" "FiraCode" ];
      })
      carlito
      corefonts
      hasklig
      mononoki
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      terminus_font
      terminus_font_ttf
      ubuntu_font_family
      font-awesome_5
      iosevka
      powerline-fonts
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    zsh.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
    };
  };


  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

