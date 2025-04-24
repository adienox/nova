{pkgs, ...}: {
  imports = [./config.nix];
  home.packages = with pkgs; [
    udiskie # AutoMount disks
    gojq # For wallpaper setting utility
    xorg.xrandr # For wallpaper setting utility
    yad # Picker
    zenity # Another picker
    wl-clipboard # Clipboard
    socat
    brightnessctl
    blueman

    # recorder and screenshot
    grim
    slurp
    tesseract # ocr
    hyprshot
    wf-recorder
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
