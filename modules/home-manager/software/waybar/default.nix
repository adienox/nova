{ config, pkgs, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  home.packages = with pkgs; [
    noto-fonts-cjk-sans # Fonts
  ];

  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings.mainBar = {
      position = "top";
      layer = "top";
      spacing = 4;

      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
        "hyprland/submap"
        "privacy"
      ];

      modules-center = [ "custom/playerlabel" ];

      modules-right = [
        "custom/recorder"
        "battery"
        "bluetooth"
        "group/audio"
        "custom/notification"
        "group/time"
        "tray"
        "group/power"
      ];

      "hyprland/workspaces" = {
        active-only = false;
        all-outputs = true;
        disable-scroll = false;
        on-scroll-up = "hyprctl dispatch workspace e-1";
        on-scroll-down = "hyprctl dispatch workspace e+1";
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          "1" = "一";
          "2" = "二";
          "3" = "三";
          "4" = "四";
          "5" = "五";
          "6" = "六";
          "7" = "七";
          "8" = "八";
          "9" = "九";
          "10" = "十";
        };
      };

      "hyprland/submap" = {
        format = " {}";
        max-length = 8;
        tooltip = false;
      };

      "hyprland/window" = {
        format = "{initialTitle}";
        icon = true;
        rewrite = {
          ".*GNU Emacs.*" = "Emacs";
          "" = "Desktop";
        };
        separate-outputs = true;
      };

      privacy = {
        icon-spacing = 4;
        icon-size = 20;
        transition-duration = 250;
        modules = [
          {
            type = "screenshare";
            tooltip = true;
            tooltip-icon-size = 20;
          }
          {
            type = "audio-in";
            tooltip = true;
            tooltip-icon-size = 20;
          }
        ];
      };

      "custom/playerlabel" = {
        format = "<span>{}</span>";
        return-type = "json";
        max-length = 48;
        exec = ''
          ${pkgs.playerctl}/bin/playerctl -a metadata --format '{"text": "{{markup_escape(title)}}", "tooltip": "{{playerName}} : {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F
        '';
        on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "<span font='14' rise='-2000'>{icon}</span> {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-full = "";
        format-alt = "{icon} {time}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };

      bluetooth = {
        format = "";
        on-click = "blueman-manager";
        format-connected = " {device_alias}";
        format-connected-battery = " {device_alias} {device_battery_percentage}%";
      };

      backlight = {
        format = "{icon} {percent}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
        ];
      };

      pulseaudio = {
        format = "{icon}";
        format-bluetooth = " {icon}";
        format-bluetooth-muted = " ";
        format-muted = "";
        format-icons = {
          default = [
            ""
            ""
            ""
          ];
        };
        reverse-mouse-scrolling = true;
        reverse-scrolling = true;
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        on-click-right = "pwvucontrol";
      };

      "pulseaudio#volume" = {
        format = "{volume}%";
        tooltip = false;
      };

      "group/audio" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          transition-left-to-right = false;
        };
        modules = [
          "pulseaudio"
          "pulseaudio#volume"
        ];
      };

      clock = {
        format = " {:%H:%M}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month"; # month/year
          mode-mon-col = 3; # only relevant if mode is year
          weeks-pos = "right";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months = "<span color='#${colors.base07}'><b>{}</b></span>";
            days = "<span color='#${colors.base05}'><b>{}</b></span>";
            weeks = "<span color='#${colors.base0C}'><b>W{}</b></span>";
            weekdays = "<span color='#${colors.base0A}'><b>{}</b></span>";
            today = "<span color='#${colors.base08}'><b>{}</b></span>";
          };
        };
        actions = {
          on-click = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };

      "clock#date" = {
        tooltip = false;
        format = " {:%B %d, %Y}";
      };

      "group/time" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          transition-left-to-right = false;
        };
        modules = [
          "clock"
          "clock#date"
        ];
      };

      tray = {
        spacing = 12;
      };

      "group/power" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "not-power";
          transition-left-to-right = false;
        };
        modules = [
          "custom/power" # First element is the "group leader" and won't ever be hidden
          "custom/quit"
          "custom/lock"
          "custom/reboot"
        ];
      };

      "custom/quit" = {
        format = "";
        tooltip = false;
        on-click = "hyprctl dispatch exit";
      };

      "custom/lock" = {
        format = "";
        tooltip = false;
        on-click = "swaylock";
      };

      "custom/reboot" = {
        format = "";
        tooltip = false;
        on-click = "reboot";
      };

      "custom/power" = {
        format = "";
        tooltip = false;
        on-click = "shutdown now";
      };
    };
  };

  xdg.configFile = {
    "waybar/colors.css".source = (
      config.lib.stylix.colors {
        template = builtins.readFile ./theme.css.mustache;
        extension = "css";
      }
    );
  };
}
