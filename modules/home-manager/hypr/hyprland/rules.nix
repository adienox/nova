{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        # Floating Rules
        "float, class:yad"
        "float, class:file_progress"
        "float, class:confirm"
        "float, class:dialog"
        "float, class:download"
        "float, class:notification"
        "float, class:error"
        "float, class:splash"
        "float, class:confirmreset"
        "float, class:title:Open File"
        "float, class:title:branchdialog"
        "float, class:org.pulseaudio.pavucontrol"
        "float, class:file-roller"
        "float, class:title:DevTools"
        "float, class:org.pwmt.zathura"
        "float, class:imv"
        "float, class:blueman-manager"
        "float, class:org.gnome.Calculator"
        "float, class:org.gnome.clocks"

        #Size, Move, and Pin rules
        "move 1430 45, title:^(Discord Popout)$"
        "pin, title:^(Discord Popout)$"
        "size 485 300, title:^(Discord Popout)$"
        "size 800 500, class:floating"
        "size 800 500, class:imv"

        # Animation Rules
        "animation popin, title:^(Discord Popout)$"
        "animation popin, floating:1"

        # Workspace Rules
        "workspace 3, class:mpv"
        "workspace 4, class:org.telegram.desktop"
        "workspace 5, class:vesktop"

        # Fullscreen Rules
        "fullscreen, class:emacs"
        "fullscreen, class:mpv"
        "fullscreen, class:org.pwmt.zathura"

        # centering
        "center, class:floating"
        "center, class:imv"

        # picture in picture
        "workspace 1, title:Picture-in-Picture"
        "fullscreen,  title:Picture-in-Picture"

        # Idle inhibit rules
        "idleinhibit fullscreen, class:zen"
        "idleinhibit fullscreen, class:mpv"
        "idleinhibit focus,      class:discord"

        # Opacity Rules
        "opacity 0.7, floating:1"

        "opacity 1, class:floating"
        "opacity 1, class:discord, fullscreen:1"

        "opacity 0.9, class:vesktop"
        "opacity 0.99, class:obsidian"
      ];
      workspace = [
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

        "blur, anyrun"
        "ignorealpha 0.5, anyrun"

        "animation slide, waybar"
        "blur, waybar"
        "xray 1, waybar"
        "ignorealpha 0.39, waybar"

        "noanim, swww"
        "blur, logout_dialog"

        "blur, notifications"
        "ignorezero, notifications"

        "blur, gtk-layer-shell"
        "ignorezero, gtk-layer-shell"
      ];
    };
  };
}
