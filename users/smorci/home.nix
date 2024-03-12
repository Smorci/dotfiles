{ config, pkgs, lib, ... }:

let
  userNeovim = import ./app/nvim/nvim.nix pkgs;
  userSway = import ./app/sway/sway.nix pkgs;
  userFoot = import ./app/foot/foot.nix pkgs;
  userStarship = import ./app/starship/starship.nix pkgs;
  userZsh = import ./app/zsh/zsh.nix { inherit pkgs config; };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "smorci";
    homeDirectory = "/home/smorci";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Wayland
  wayland.windowManager.sway = userSway;

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    gpg.enable = true;

    go.enable = true;

    neovim = userNeovim;

    foot = userFoot;

    starship = userStarship;

    zsh = userZsh;

    swaylock = {
      enable = true;
      settings = {
        daemonize = true;
        ignore-empty-password = true;
        hide-keyboard-layout = true;
        line-uses-inside = true;
        font = "Terminus";
        indicator-radius = "128";
        indicator-thickness = "32";
        color = "000000";
        separator-color = "00000000";
        bs-hl-color = "b48ead";
        key-hl-color = "5e81ac";
        caps-lock-bs-hl-color = "b48ead";
        caps-lock-key-hl-color = true;
        inside-color = "2e344000";
        inside-clear-color = "2e344000";
        inside-caps-lock-color = true;
        inside-ver-color = "2e344000";
        inside-wrong-color = "2e344000";
        ring-color = "4c566a";
        ring-clear-color = "81a1c1";
        ring-caps-lock-color = "4c566a";
        ring-ver-color = "ebcb8b";
        ring-wrong-color = "bf616a";
        text-color = "ffffff00";
        text-clear-color = "2e344000";
        text-caps-lock-color = "4c566a";
        text-ver-color = "2e344000";
        text-wrong-color = "2e344000";
      };
    };


    i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [
            {
              alert = 10.0;
              block = "disk_space";
              info_type = "available";
              interval = 60;
              path = "/";
              warning = 20.0;
            }
            {
              block = "memory";
              format = " $icon mem_used_percents ";
              format_alt = " $icon $swap_used_percents ";
            }
            {
              block = "cpu";
              interval = 1;
            }
            {
              block = "load";
              format = " $icon $1m ";
              interval = 1;
            }
            {
              block = "sound";
            }
            {
              block = "time";
              format = " $timestamp.datetime(f:'%a %d/%m %R') ";
              interval = 60;
            }
          ];
          icons = "awesome6";
          theme = "gruvbox-light";
        };
      };
    };

    direnv = {
      enable = true;
      nix-direnv = { enable = true; };
    };
  };

  services = {

    swayidle.enable = true;

    gpg-agent = {
      enable = true;
      pinentryFlavor = "qt";
      defaultCacheTtl = 28800;
      maxCacheTtl = 30000;
    };
  };

  home.packages = with pkgs; [

    # LSP
    rnix-lsp
    rust-analyzer
    lua-language-server

    # Editor
    micro

    # YAML
    yamlfmt

    # Nix
    nix-output-monitor
    nixos-option
    nixpkgs-fmt
    statix

    # Rust
    cargo

    # Helm
    helmfile
    kubernetes-helm

    # Kubernetes
    kubectl
    kubectx
    kubeconform

    # Docker
    docker

    # Terraform
    terraform

    # AWS
    awscli

    # Git
    git-crypt
    github-cli
    tig

    # GnuPG
    gnupg
    pinentry-qt

    # DB
    postgresql

    # CLI Tools
    stern
    choose
    starship
    bat
    pciutils
    sd
    jira-cli-go
    jq
    gawk
    age
    gnumake
    rofi
    dpkg
    patchelf
    binutils
    coreutils
    unzip
    gnutar
    direnv
    nix-direnv
    ripgrep
    htop

    # Desktop
    pavucontrol
    firefox
    brave
    _1password-gui
    obs-studio
    discord
    transmission-gtk
    flameshot
    tdesktop
    soulseekqt
    pcmanfm
    vlc
    mpv
    libreoffice

    # Hardware
    openrazer-daemon
    razergenie
    ledger-live-desktop

    # Networking
    krew
    dig
    dnsutils

    # Fun
    ani-cli
    wine

  ];


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";
}
