{
  config,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors;
in {
  home.packages = with pkgs; [
    noto-fonts-cjk-sans # Fonts
    icomoon-feather
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

      modules-center = ["custom/playerlabel"];

      modules-right = [
        "group/bt"
        "group/net"
        "battery"
        "group/audio"
        "group/time"
        "tray"
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
          ".*- Obsidian .*" = "Obsidian";
          "" = "Desktop";
        };
        separate-outputs = true;
      };

      privacy = {
        modules = [
          {
            type = "screenshare";
            tooltip-icon-size = 20;
          }
          {
            type = "audio-in";
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
        format-connected = " {device_alias}";
        format-connected-battery = " {device_alias}";
      };

      "bluetooth#battery" = {
        format = "";
        format-connected = "";
        format-connected-battery = "{device_battery_percentage}%";
      };

      "group/bt" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          transition-left-to-right = true;
        };
        modules = [
          "bluetooth"
          "bluetooth#battery"
        ];
      };

      network = {
        format-wifi = "  {essid}";
        format-disconnected = "";
        tooltip-format = "{ipaddr}/{frequency}GHz";
        interval = 7;
      };

      "network#strength" = {
        format-wifi = "({signalStrength}%)";
        tooltip = false;
        interval = 7;
      };

      "group/net" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          transition-left-to-right = true;
        };
        modules = [
          "network"
          "network#strength"
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
            today = "<span color='#${colors.base0B}'><b>{}</b></span>";
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
