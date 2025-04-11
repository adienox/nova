{
  config,
  ...
}:
{
  wayland.windowManager.hyprland = {
    settings = {
      "$MOD" = "SUPER";
      "$ALT" = "ALT";
      "$SCRIPTS" = "${config.xdg.configHome}/assets/scripts/hypr";
      "$ROFI" = "${config.xdg.configHome}/assets/scripts/rofi";
      "$TERM" = "kitty";
      "$FLOATING_TERM" = "kitty --class floating -e";

      bind = [
        # Term
        "$MOD, RETURN, exec, $TERM"
        "$MOD SHIFT, RETURN, exec, kitty --start-as=fullscreen -o 'font_size=16' --title all_is_kitty"

        # Applications
        "$MOD, W, exec, $SCRIPTS/focus.sh zen zen"
        "$MOD, E, exec, $SCRIPTS/emacs.sh"

        ", XF86Calculator, exec, gnome-calculator"

        # Rofi
        "$MOD, B, exec, rofi-bluetooth"
        "$MOD, I, exec, rofi -show emoji"
        "$MOD, Space, exec, rofi -show drun"
        "$MOD, X, exec, $ROFI/powermenu.sh"
        "$MOD, C, exec, $ROFI/network-manager.sh"

        # Hyprland Bindings
        "$MOD SHIFT, Q, killactive, "
        "$MOD, F, togglefloating, "
        "$MOD, P, exec, $SCRIPTS/window-pin.sh"

        # Scroll through workspace
        "$MOD, mouse_down, workspace, e+1"
        "$MOD, mouse_up, workspace, e-1"

        # Misc
        ", F11, exec, hyprctl dispatch fullscreen"
        ", F9, exec, pkill waybar || waybar"
        "$MOD SHIFT, W, exec, $SCRIPTS/switchwall.sh"
        "$MOD, C, exec, hyprctl dispatch centerwindow"

        # Group bindings
        "$MOD,g,togglegroup"
        "$MOD,tab,changegroupactive"

        # Focus last window
        "$MOD, N, focuscurrentorlast"

        # Move focus with MOD + vim keys
        "$MOD, H, movefocus, l"
        "$MOD, J, movefocus, d"
        "$MOD, K, movefocus, u"
        "$MOD, L, movefocus, r"

        # Move window with MOD + vim keys
        "$MOD SHIFT, H, movewindow, l"
        "$MOD SHIFT, J, movewindow, d"
        "$MOD SHIFT, K, movewindow, u"
        "$MOD SHIFT, L, movewindow, r"

        # Switch workspaces with MOD + [0-9]
        "$MOD, 1, exec, $SCRIPTS/switchwindow.sh 1"
        "$MOD, 2, exec, $SCRIPTS/switchwindow.sh 2"
        "$MOD, 3, exec, $SCRIPTS/switchwindow.sh 3"
        "$MOD, 4, exec, $SCRIPTS/switchwindow.sh 4"
        "$MOD, 5, exec, $SCRIPTS/switchwindow.sh 5"
        "$MOD, 6, exec, $SCRIPTS/switchwindow.sh 6"
        "$MOD, 7, exec, $SCRIPTS/switchwindow.sh 7"
        "$MOD, 8, exec, $SCRIPTS/switchwindow.sh 8"
        "$MOD, 9, exec, $SCRIPTS/switchwindow.sh 9"
        "$MOD, 0, exec, $SCRIPTS/switchwindow.sh 10"

        "$MOD $ALT, h, workspace, 1"
        "$MOD $ALT, j, workspace, 2"
        "$MOD $ALT, k, workspace, 3"
        "$MOD $ALT, l, workspace, 4"

        # Move active window to a workspace with MOD + SHIFT + [0-9]
        "$MOD SHIFT, 1, movetoworkspace, 1"
        "$MOD SHIFT, 2, movetoworkspace, 2"
        "$MOD SHIFT, 3, movetoworkspace, 3"
        "$MOD SHIFT, 4, movetoworkspace, 4"
        "$MOD SHIFT, 5, movetoworkspace, 5"
        "$MOD SHIFT, 6, movetoworkspace, 6"
        "$MOD SHIFT, 7, movetoworkspace, 7"
        "$MOD SHIFT, 8, movetoworkspace, 8"
        "$MOD SHIFT, 9, movetoworkspace, 9"
      ];

      bindel = [
        # Brightness Control
        ", XF86MonBrightnessUp, exec, $SCRIPTS/brightness.sh up"
        ", XF86MonBrightnessDown, exec, $SCRIPTS/brightness.sh down"

        # Weird keybindings to make my keybord knob function
        "SHIFT, XF86AudioRaiseVolume, exec, $SCRIPTS/brightness.sh up"
        "SHIFT, XF86AudioLowerVolume, exec, $SCRIPTS/brightness.sh down"
        "SHIFT, XF86AudioMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"

        # Audio Control
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

        # Screenshot
        ", Print, exec, $ROFI/screenshot.sh"
        "SHIFT, Print, exec, hyprshot -m region"
        "$MOD SHIFT, T, exec, $ROFI/screenshot.sh"

        # Recording
        "$MOD, R, exec, $SCRIPTS/screenrecord.sh"
        "$MOD, Prior, exec, $SCRIPTS/screenrecord.sh"
      ];

      bindl = [
        # Media Control
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", Next, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl play-stop"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      bindm = [
        # Resize and Move
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
      ];
    };
  };

  wayland.windowManager.hyprland.extraConfig = ''
    # will switch to a submap called resize
    bind = $ALT, R, submap, resize

    # will start a submap called "resize"
    submap = resize

    # sets repeatable binds for resizing the active window
    binde = , H, resizeactive, -10 0
    binde = , J, resizeactive, 0 10
    binde = , K, resizeactive, 0 -10
    binde = , L, resizeactive, 10 0

    # use reset to go back to the global submap
    bind = , escape, submap, reset

    # will reset the submap, meaning end the current one and return to the global one
    submap = reset
  '';
}
