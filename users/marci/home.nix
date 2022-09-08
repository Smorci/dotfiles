{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "marci";
  home.homeDirectory = "/home/marci";
 
  nixpkgs.config.allowUnfree = true;

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  home.packages = with pkgs; [
    git
    git-crypt
    gnupg
    pinentry_qt
    slack
    lxappearance
    rofi
    dpkg
    patchelf
    binutils
    coreutils
    discord
    arandr
    xorg.xmodmap
    transmission-gtk
    nodejs
    flameshot
    keepass
    tdesktop
    unzip
    aircrack-ng
    soulseekqt
    pcmanfm
    micro
    vlc
    xclip
    elmPackages.elm
    libreoffice
    nixfmt
    gnutar
    ];

  # gtk = {
  #   enable = true;
  #   font.name = "source-code-pro 9";
  #   theme = {
  #     name = "Juno-Theme";
  #     package = pkgs.juno-theme;
  #   };
  # };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
