{ pkgs, config, ...}:

{
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ll = "ls -al";
        k = "kubectl";
        kx = "kubectx";
        kns = "kubens";
        v = "nvim";
        rebuild = "sudo nixos-rebuild switch";
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

        export JIRA_API_TOKEN=$(cat /home/smorci/.keys/jira_api_token)

        [[ -z $DISPLAY ]] && [ "$(tty)" = "/dev/tty1" ] && mkdir -p ~/.log && exec bash -c 'sway > ~/.log/sway-$(tty | grep -oE "[^/]+$").log 2>&1 '
      '';
    }
