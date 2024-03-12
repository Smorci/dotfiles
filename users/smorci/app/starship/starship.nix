{ pkgs, lib, ... }:

{
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
}
