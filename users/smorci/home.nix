{ config, pkgs, ... }:

let secrets = import ./secrets/mina.nix;
in {

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "smorci";
    homeDirectory = "/home/smorci";
  };

  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
      enablePepperFlash = true;
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    gpg.enable = true;

    go.enable = true;
    
    neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        vim-json
        vim-go
        vim-nix
        vim-terraform
        vim-markdown

        nvim-lspconfig
        lsp-status-nvim
        nvim-cmp
        cmp-buffer
        cmp-nvim-lsp
        cmp-path
        cmp-treesitter
        cmp-vsnip

        nerdtree
        vim-gitgutter
        vim-commentary
        vim-airline
        fugitive
        vim-surround
        oceanic-next
        nvim-treesitter
        nvim-lspconfig
        vim-yaml
      ];

      extraConfig = ''
        syntax enable

        set ignorecase
        set number
        set expandtab
        set tabstop=2
        set shiftwidth=2

        if (has("termguicolors"))
          set termguicolors
        endif

        colorscheme OceanicNext
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      '';
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ll = "ls -al";
        k = "kubectl";
        kx = "kubectx";
        kns = "kubens";
        v = "nvim";
        switcharoo = "sudo nixos-rebuild switch";
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
      initExtra = ''
        DEFAULT_USER=$USER
        pr () { 
          gh pr create --assignee "@me" --reviewer kaozenn,simisimis --fill "$@"
        }
        todo () {
          local description="$*" # get all arguments
          jira issue create --template ~/.config/.jira/issue-template.yml \
            -tTask \
            --custom team=4df12a6f-710c-4bc9-a8e9-a8a77b54567d \
            --component="DevOps" \
            --summary "$description"
          issuekey=$(jira issue list --assignee $(jira me) | awk -F '\t' -v desc="$description" '$3 == desc { print $2 }')
          sprintnr=$(jira sprint list --state=active --plain --table --columns id --no-headers)
          jira sprint add $sprintnr $issuekey
        }
        export JIRA_API_TOKEN=${secrets.apiKeys.jira}
      '';
    };
    direnv = {
      enable = true;
      nix-direnv = { enable = true; };
    };
  };

  services = {

    gpg-agent = {
      enable = true;
      pinentryFlavor = "qt";
      defaultCacheTtl = 28800;
      maxCacheTtl = 30000;
    };
  };

  home.packages = with pkgs; [
    nix-output-monitor
    nixpkgs-fmt
    ledger-live-desktop
    git-crypt
    pavucontrol
    bat
    pciutils
    firefox
    helmfile
    jira-cli-go
    yarn
    _1password-gui
    github-cli
    jq
    awscli
    kubectl
    kubectx
    kubernetes-helm
    age
    obs-studio
    gnumake
    gnupg
    pinentry-qt
    lxappearance
    rofi
    dpkg
    patchelf
    binutils
    coreutils
    discord
    arandr
    brave
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
    nodejs_18
    htop
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
