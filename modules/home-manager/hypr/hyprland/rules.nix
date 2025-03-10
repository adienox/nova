{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        # Floating Rules
        "float, title:^(fly_is_kitty)$"
        "float, title:^(all_is_kitty)$"
        "float, title:^(Discord Popout)$"
        "float, yad"
        "float, floating"
        "float, file_progress"
        "float, confirm"
        "float, dialog"
        "float, download"
        "float, notification"
        "float, error"
        "float, splash"
        "float, confirmreset"
        "float, title:Open File"
        "float, title:branchdialog"
        "float, feh"
        "float, org.pulseaudio.pavucontrol"
        "float, file-roller"
        "float, title:DevTools"
        "float, org.pwmt.zathura"
        "float, imv"
        "float, blueman-manager"
        "float, org.gnome.Calculator"
        "float, org.gnome.clocks"

        #Size, Move, and Pin rules
        "pin, title:^(Discord Popout)$"

        "move 1430 45, title:^(Discord Popout)$"
        "move 560 290, title:^(fly_is_kitty)$"

        "size 485 300, title:^(Discord Popout)$"
        "size 800 500, ^(floating)$"
        "size 800 500, ^(imv)$"

        # Animation Rules
        "animation popin, title:^(Discord Popout)$"

        # Workspace Rules
        "workspace 3, ^(mpv)$"
        "workspace 4, ^(org.telegram.desktop)$"
        "workspace 5, ^(vesktop)$"
        "workspace 9, ^(org.rncbc.qpwgraph)$"

        # Fullscreen Rules
        "fullscreen, emacs"
        "fullscreen, mpv"
        "fullscreen, org.pwmt.zathura"
      ];
      windowrulev2 = [
        # Utils
        "noshadow, floating:0"
        "animation popin, floating:1"

        # centering
        "center, class:^(firefox)$, title:^(Enter name of file to save to…)$"
        "center, class:^(floating)$"
        "center, class:^(imv)$"

        # picture in picture
        "workspace 1, title:Picture-in-Picture"
        "fullscreen, title:Picture-in-Picture"

        # Idle inhibit rules
        "idleinhibit fullscreen, class:^(firefox)$"
        "idleinhibit focus, class:^(ticktick)$"
        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit focus, class:^(discord)$"

        # Opacity Rules
        "opacity 0.7, floating:1"

        "opacity 1, class:^(floating)$"
        "opacity 1, class:^(discord), fullscreen:1"

        "opacity 0.9, class:^(Anki)$"
        "opacity 0.9, class:^(vesktop)$"
        "opacity 0.9, class:^(calibre-gui)$"

        "float, class:^(Anki)$, title:^(Add)$"
        "center, class:^(Anki)$, title:^(Add)$"
        "float, class:^(Anki)$, title:^(Preferences)$"
        "center, class:^(Anki)$, title:^(Preferences)$"

        # Wlogout
        "noanim, class:^(wlogout)$, title:^(wlogout)$"
        "noshadow, class:^(wlogout)$, title:^(wlogout)$"

        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];
      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
        "1, monitor:eDP-1, default:true"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
        "5, monitor:HDMI-A-1, default:true"
        "6, monitor:HDMI-A-1"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "10, monitor:HDMI-A-1"
      ];
      layerrule = [
        "blur, rofi"
        "ignorezero, rofi"

        "animation popin 50%, rofi"
        "animation slide, waybar"
        "noanim, swww"
        "blur, logout_dialog"

        "blur, waybar"
        "ignorezero, waybar"
        "xray 1, waybar"
        "ignorealpha 0.39, waybar"

        "blur, notifications"
        "ignorezero, notifications"

        "blur, gtk-layer-shell"
        "ignorezero, gtk-layer-shell"
      ];
    };
  };
}
