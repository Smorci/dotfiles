{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "marci";
  home.homeDirectory = "/home/marci";

  nixpkgs.config.allowUnfree = true;

  programs = {
    gpg.enable = true;
    go.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ll = "ls -l";
        k = "kubectl";
        kx = "kubectx";
        kns = "kubens";
        v = "vim";
      };
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "z" ];
        custom = "$HOME/.oh-my-custom";
        theme = "agnoster-nix";
      };
      plugins = [{
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }];
      initExtra =
        "	eval \"$(direnv hook zsh)\"\n	DEFAULT_USER=$USER\n	pr () {\n		gh pr create --assignee \"@me\" --reviewer kaozenn,simisimis,michal0mina --fill \"$@\"\n	}\n";
    };
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
    defaultCacheTtl = 28800;
    maxCacheTtl = 30000;
  };

  home.sessionVariables = { EDITOR = "vim"; };

  home.packages = with pkgs; [
    git-crypt
    bat
    firefox
    helmfile
    github-cli
    jq
    awscli
    kubectl
    kubectx
    kubernetes-helm
    age
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
    notion-app-enhanced
    direnv
    nix-direnv
    ripgrep
    terraform
    kubeconform
  ];

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
