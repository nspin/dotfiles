{ pkgs, ... }: {

  environment.systemPackages = with pkgs.xfce; [

    xfce4_battery_plugin
    xfce4_clipman_plugin
    xfce4_cpufreq_plugin
    xfce4_cpugraph_plugin
    xfce4_datetime_plugin
    xfce4_embed_plugin
    xfce4_eyes_plugin
    xfce4_fsguard_plugin
    xfce4_genmon_plugin
    xfce4-hardware-monitor-plugin
    xfce4_netload_plugin
    xfce4_mpc_plugin
    xfce4-sensors-plugin
    xfce4_systemload_plugin
    xfce4_verve_plugin
    xfce4_whiskermenu_plugin
    xfce4_windowck_plugin
    xfce4_pulseaudio_plugin

  ];

}
