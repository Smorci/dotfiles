general {
        colors = true
        interval = 5
}

order += "volume master"
order += "cpu_usage"
order += "disk /"
order += "wireless _first_"
order += "battery all"
order += "memory"
order += "load"
order += "tztime local"

volume master {
        format = "VOL  %volume"
        format_muted = "VOL  muted"
        device = "default"
        mixer = "Master"
        mixer_idx = 0
}

cpu_usage {
        format= "CPU  %usage <%cpu0 %cpu1>"
        max_threshold= 75
}

wireless _first_ {
        format_up = " (%quality at %essid, %bitrate) %ip"
        format_down = " down"
}

battery all {
        format = "%status %percentage %remaining %emptytime"
        format_down = ""
        status_chr = ""
        status_bat = ""
        status_unk = ""
        status_full = ""
        path = "/sys/class/power_supply/BAT%d/uevent"
        low_threshold = 10
}

tztime local {
        format = " %Y-%m-%d %H:%M"
}

load {
        format = " %1min %5min %15min"
}

memory {
        format = "MEM  %percentage_used"
        threshold_degraded = "10%"
        format_degraded = "MEMORY: %free"
}

disk "/" {
        format = "HDD  %percentage_used %avail"
}
