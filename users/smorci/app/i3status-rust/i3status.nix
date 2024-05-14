pkgs:

{
  enable = true;
  bars.default = {
    theme = "solarized-dark";
    icons = "material-nf";
    settings.invert_scrolling = true;

    blocks = [
      { block = "battery"; format = "$icon $percentage $time "; good = 90; info = 20; warning = 10; critical = 5; }
      { block = "net"; format = "$icon  ^icon_net_down $graph_down$speed_down.eng(prefix:K) ^icon_net_up $graph_up$speed_up.eng(prefix:K) $ssid $frequency $signal_strength $bitrate $ip"; }
      # { block = "external_ip"; use_ipv4 = true; format = "$ip $country"; }
      # { block = "bluetooth"; }
      { block = "disk_space"; path = "/"; format = "$icon $available"; }
      { block = "memory"; format = "$icon$mem_used_percents.eng(w:2)"; }
      { block = "cpu"; }
      { block = "load"; }
      { block = "temperature"; format = "$icon$max"; }
      { block = "keyboard_layout"; driver = "sway"; format = " ^icon_keyboard $layout.str(max_w:2)"; }
      { block = "backlight"; }
      { block = "sound"; }
      # { block = "privacy"; driver.name = "pipewire"; }
      { block = "time"; timezone = "UTC"; format = "$icon  $timestamp.datetime(f:'%Y-%m-%d %H:%M') utc|"; }
      { block = "time"; timezone = "Europe/Bucharest"; format = "$timestamp.datetime(f:'%H:%M') ro|"; }
      { block = "time"; timezone = "Europe/Lisbon"; format = "$timestamp.datetime(f:'%H:%M') pt|"; }
    ];
  };
  # bars.net = {
  #   theme = "solarized_dark";
  #   icons = "material-nf";
  #   settings.invert_scrolling = true;
  #   blocks = [
  #     { block = "net"; format = "$icon ^icon_net_down $graph_down$speed_down.eng(prefix:K) ^icon_net_up $graph_up$speed_up.eng(prefix:K) $ssid $frequency $signal_strength $bitrate $ip"; }
  #     { block = "external_ip"; use_ipv4 = true; format = "$ip $country"; }
  #   ];
  # };
}
