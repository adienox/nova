{
  pkgs,
  config,
  ...
}: {
  # Disable Watchdogs
  # https://wiki.archlinux.org/title/Improving_performance#Watchdogs
  # https://wiki.archlinux.org/title/Power_management#Disabling_NMI_watchdog
  # Enabling powersave on https://wiki.archlinux.org/title/Power_management#Network_interfaces
  # Enabling powersave on https://wiki.archlinux.org/title/Power_management#Intel_wireless_cards_(iwlwifi)
  # Enabling powersave on https://wiki.archlinux.org/title/Power_management#Audio
  # Enabling powersave on pci devices https://github.com/NixOS/nixpkgs/issues/211345#issuecomment-1397825573
  # Increasing virtual memory https://wiki.archlinux.org/title/Power_management#Writeback_Time
  boot = {
    extraModprobeConfig = ''
      options iwlwifi power_save=1
      options iwlmvm power_scheme=3
      options snd_hda_intel power_save=1
      blacklist sp5100_tco
    '';
    kernel.sysctl = {
      "vm.dirty_writeback_centisecs" = 1500;
      "vm.laptop_mode" = 5;
    };
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
  };

  services.gvfs.enable = true;
  services.upower.enable = true;
  services = {
    power-profiles-daemon.enable = false;
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="net", KERNEL=="wl*", RUN+="${pkgs.iw}/bin/iw dev $name set power_save on"
    '';
    tlp = {
      enable = true;
      settings = {
        CPU_DRIVER_OPMODE_ON_AC = "active";
        CPU_DRIVER_OPMODE_ON_BAT = "active";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";
        RADEON_DPM_STATE_ON_AC = "balanced";
        RADEON_DPM_STATE_ON_BAT = "battery";

        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        MEM_SLEEP_ON_AC = "deep";
        MEM_SLEEP_ON_BAT = "deep";

        RUNTIME_PM_ON_AC = "auto";
        RUNTIME_PM_ON_BAT = "auto";

        SATA_LINKPWR_ON_AC = "med_power_with_dipm";
        SATA_LINKPWR_ON_BAT = "med_power_with_dipm";

        NMI_WATCHDOG = 0;
        WOL_DISABLE = "Y";
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";
        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth wifi";
      };
    };
  };
}
