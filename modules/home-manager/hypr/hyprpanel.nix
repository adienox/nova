{
  config,
  lib,
  inputs,
  ...
}:
let
  xcolors = config.lib.stylix.colors.withHashtag;
in
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    overlay.enable = true;
    enable = true;
    hyprland.enable = true;
    overwrite.enable = false;
    theme = lib.mkDefault "catppuccin_mocha";

    # Override the final config with an arbitrary set.
    # Useful for overriding colors in your selected theme.
    # Default: {}
    override = {
      theme.bar.background = xcolors.base00;
      theme.bar.buttons.background = xcolors.base01;
    };

    # Configure bar layouts for monitors.
    # See 'https://hyprpanel.com/configuration/panel.html'.
    # Default: null
    layout = {
      "bar.layouts" = {
        "0" = {
          left = [
            "dashboard"
            "workspaces"
            "windowtitle"
          ];
          middle = [ "media" ];
          right = [
            "volume"
            "network"
            "battery"
            "bluetooth"
            "clock"
            "notifications"
          ];
        };
        "1" = {
          left = [
            "workspaces"
            "windowtitle"
          ];
          middle = [ "media" ];
          right = [
            "volume"
            "clock"
            "notifications"
          ];
        };
      };
    };
    # See 'https://hyprpanel.com/configuration/settings.html'.
    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;
      bar.clock.format = "%b %d, %H:%M";
      bar.battery.hideLabelWhenFull = true;

      menus.clock = {
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = false;

      theme.bar.transparent = false;
      theme.bar.outer_spacing = "0em";
      theme.bar.dropdownGap = "3.2em";
      theme.osd.muted_zero = true;
      menus.power.lowBatteryNotification = true;
      menus.dashboard.powermenu.avatar.image = "${config.home.homeDirectory}/.face";

      theme.font = {
        name = config.stylix.fonts.monospace.name;
        size = "16px";
      };
    };
  };

  specialisation.light.configuration.programs.hyprpanel = {
    theme = "catppuccin_latte";
  };
}
