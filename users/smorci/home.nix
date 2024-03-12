{ config, pkgs, lib, ... }:

let
  userNeovim = import ./app/nvim/nvim.nix pkgs;
  userSway = import ./app/sway/sway.nix pkgs;
  userFoot = import ./app/foot/foot.nix pkgs;
  userStarship = import ./app/starship/starship.nix pkgs;
  userZsh = import ./app/zsh/zsh.nix { inherit pkgs config; };
  userSwaylock = import ./app/swaylock/swaylock.nix pkgs;
  userI3status = import ./app/i3status-rust/i3status.nix pkgs;
  userSwayidle = import ./app/swayidle/swayidle.nix pkgs;
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

    swaylock = userSwaylock;

    i3status-rust = userI3status;

    direnv = {
      enable = true;
      nix-direnv = { enable = true; };
    };
  };

  services = {

    swayidle = userSwayidle;

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
