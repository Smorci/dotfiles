pkgs: 
{
  enable = true;
  settings = {
    main = {
      dpi-aware = "yes";
      font-size-adjustment = "1.5";
    };
    cursor = {
      blink = "yes";
      style = "beam";
    };
    mouse = {
      hide-when-typing = "yes";
    };
    scrollback = {
      lines = "10000";
    };
    # Everforest soft color theme
    colors = {
      # Base
      alpha = "1.0";
      background = "333C43";
      foreground = "D3C6AA";
      flash = "3A464C";
      # Regular colors
      regular0 = "1B1916";  # black
      regular1 = "E67E80";  # red
      regular2 = "A7C080";  # green
      regular3 = "DBBC7F";  # yellow
      regular4 = "BD93F9";  # purple
      regular5 = "E69875";  # orange
      regular6 = "7FBBB3";  # cyan
      regular7 = "C7C5C0";  # white

    };
  };
}
