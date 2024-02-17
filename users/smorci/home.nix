{ config, pkgs, lib, ... }:

let 
  secrets = import ./secrets/mina.nix;
  userNeovim = import ./nvim/nvim.nix;
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "smorci";
    homeDirectory = "/home/smorci";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    gpg.enable = true;

    go.enable = true;
    
    neovim = userNeovim pkgs;

    starship  = {
        enable = true;
        enableZshIntegration = true;
        settings = {
            add_newline = false;
            format = lib.concatStrings [
                "$shlvl"
                "$shell"
                "$nix_shell"
                "$directory"
                "$git_branch"
                "$git_commit"
                "$git_state"
                "$git_metrics"
                "$git_status"
                "$direnv"
                "$kubernetes"
                "$line_break"
                "$character"
            ];

            palette = "everforest";

            palettes = {
                everforest = {
                    background = "#333C43";
                    current_line = "#3A464C";
                    foreground = "#D3C6AA";
                    comment = "#9DA9A0";
                    cyan = "#7FBBB3";
                    green = "#A7C080";
                    orange = "#E69875";
                    pink = "#D699B6";
                    purple = "#BD93F9";
                    red = "#E67E80";
                    yellow = "#DBBC7F";
                };
            };

#            character = {
#                success_symbol = "[⊳] (bold yellow) ";
#                error_symbol = "[⋫] (bold red) ";
#            };

        };
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
        justpull = "git pull origin main --no-ff";
      };
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "z" "ripgrep" "python" "rust" ];
        custom = "$HOME/.oh-my-custom";
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
            -a $(jira me) \
            --custom team=4df12a6f-710c-4bc9-a8e9-a8a77b54567d \
            --component="DevOps" \
            --summary "$description"
          sleep 2
          issuekey=$(jira issue list --assignee $(jira me) | choose 1 | head -n 2 | tail -n 1 | tr -d ' ')
          sprintnr=$(jira sprint list --state=active --plain --table --columns id --no-headers --component DevOps | head -n 1 | tr -d ' ')
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

    # LSP
    rnix-lsp
    rust-analyzer
    lua-language-server

    cargo
    stern
    ani-cli
    choose
    nix-output-monitor
    nixpkgs-fmt
    ledger-live-desktop
    starship
    git-crypt
    pavucontrol
    bat
    wine
    ani-cli
    pciutils
    firefox
    sd
    helmfile
    jira-cli-go
    yarn
    _1password-gui
    github-cli
    jq
    statix
    dig
    dnsutils
    gawk
    tig
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
    postgresql
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
  home.stateVersion = "23.11";
}
