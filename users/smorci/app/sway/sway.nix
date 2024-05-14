pkgs:
{
  enable = true;
  config = {
    modifier = "Mod4";
    terminal = "foot";
    startup  = [ { command = "swayidle"; } ];
    input."*" = {
      repeat_delay = "200";
      repeat_rate = "32";
      xkb_layout = "us,hu,ro";
      xkb_options = "grp:switch,grp:lalt_lshift_toggle";
    };
    input."type:touchpad" = {
      tap = "enabled";
      tap_button_map = "lrm";
      middle_emulation = "enabled";
      natural_scroll = "enabled";
    };
    menu = "rofi -show drun";
    window = {
      titlebar = false;
      hideEdgeBorders = "both";
    };
    colors = {
      background = "#434F55";
      focused = {
        background = "#434F55";
        border = "#434F55";
        childBorder = "#434F55";
        indicator = "#00ff00";
        text = "#DFECF0";
      };
      unfocused = {
        background = "#333C43";
        border = "#333C43";
        childBorder = "#333C43";
        indicator = "#00ff00";
        text = "#BFCCD0";
      };
      focusedInactive = {
        background = "#333C43";
        border = "#333C43";
        childBorder = "#333C43";
        indicator = "#00ff00";
        text = "#BFCCD0";
      };
      urgent = {
        background = "#FF6C68";
        border = "#FF6C68";
        childBorder = "#FF6C68";
        indicator = "#00ff00";
        text = "#DFECF0";
      };
    };
    bars = [
      {
        colors = {
          background = "#434F55";
          focusedWorkspace = {
            background = "#434F55";
            border = "#434F55";
            text = "#DFECF0";
          };
          inactiveWorkspace = {
            background = "#333C43";
            border = "#333C43";
            text = "#BFCCD0";
          };
          urgentWorkspace = {
            background = "#FF6C68";
            border = "#FF6C68";
            text = "#DFECF0";
          };
          separator = "#757575";
        };
        command = "swaybar";
        mode = "hide";
        statusCommand = "i3status-rs /home/smorci/.config/i3status-rust/config-default.toml";
      }
    ];
  };
  extraConfig = ''
    # Brightness
    bindsym XF86MonBrightnessDown exec light -U 10
    bindsym XF86MonBrightnessUp exec light -A 10
      
    # Volume
    bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
    bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
    bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
  '';
  extraSessionCommands = ''
    export SDL_VIDEODRIVER=wayland
  '';
}
