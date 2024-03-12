pkgs:
let
  i-monitor-off-unless-audio-hdmi = pkgs.writeShellScriptBin "i-monitor-off-unless-audio-hdmi" ''
    pactl list | grep -Pzo "(?s)RUNNING\n\N*?hdmi" && exit 1
    # swaymsg "seat seat0 hide_cursor 1000"
    exec swaymsg "output * dpms off"
  '';
  i-suspend-unless-audio = pkgs.writeShellScriptBin "i-suspend-unless-audio" ''
    pactl list | grep RUNNING && exit 1
    exec systemctl suspend
  '';
  i-monitor-on = pkgs.writeShellScriptBin "i-monitor-on" ''
    exec swaymsg "output * dpms on"
  '';
in
{
      enable = true;
      extraArgs = [ "-w" ]; #wait for commands to finish before continuing
      events = [
        { event = "lock"; command = "swaylock"; }
        { event = "before-sleep"; command = "swaylock"; }
        { event = "after-resume"; command = "${i-monitor-on}/bin/i-monitor-on"; }
      ];
      timeouts = [
        { timeout = 300; command = "${i-monitor-off-unless-audio-hdmi}/bin/i-monitor-off-unless-audio-hdmi"; resumeCommand = "${i-monitor-on}/bin/i-monitor-on"; }
        { timeout = 600; command = "${i-suspend-unless-audio}/bin/i-suspend-unless-audio"; }
      ];
}
