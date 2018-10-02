{ pkgs, ... }: {

  environment.systemPackages = with pkgs; with pkgs.xfce; [

    moka-icon-theme
    arc-theme
    theme-vertex

    pmtools
    pmutils
    jmtpfs
    usbutils
    sysstat

    xfce4-battery-plugin
    xfce4-clipman-plugin
    xfce4-cpufreq-plugin
    xfce4-cpugraph-plugin
    xfce4-datetime-plugin
    xfce4-embed-plugin
    xfce4-eyes-plugin
    xfce4-fsguard-plugin
    xfce4-genmon-plugin
    xfce4-hardware-monitor-plugin
    xfce4-netload-plugin
    xfce4-mpc-plugin
    xfce4-sensors-plugin
    xfce4-systemload-plugin
    xfce4-verve-plugin
    xfce4-whiskermenu-plugin
    xfce4-windowck-plugin
    xfce4-pulseaudio-plugin

  ];

}
