{ pkgs, ... }:
{
  programs = {
    mpv = {
      enable = true;

      bindings = {
        l = "seek 5";
        h = "seek -5";
        k = "add volume 5";
        j = "add volume -5";
        s = "screenshot";
        WHEEL_UP = "add volume 5";
        WHEEL_DOWN = "add volume -5";
      };

      config = {
        screenshot-template = "~/Pictures/mpvscreenshots/%F (%P) %n";
        save-position-on-quit = true;
        write-filename-in-watch-later-config = true;
        ignore-path-in-watch-later-config = true;
        cache = "yes";
        volume = 100;
        msg-color = true;
        keep-open = true;
        cursor-autohide-fs-only = true;
        cursor-autohide = 1000;
        osc = "no";
        osd-bar = "no";
        border = "no";
      };
    };
  };

  xdg.configFile = {
    "mpv/scripts/mpris.so".source = "${pkgs.mpvScripts.mpris}/share/mpv/scripts/mpris.so";

    "mpv/scripts/sponsorblock.lua".source =
      "${pkgs.mpvScripts.sponsorblock}/share/mpv/scripts/sponsorblock.lua";

    "mpv/script-opts/sponsorblock.conf".text =
      "skip_categories=sponsor,intro,outro,interaction,selfpromo,filler";

    "mpv/scripts/thumbfast.lua".source = "${pkgs.mpvScripts.thumbfast}/share/mpv/scripts/thumbfast.lua";

    #NOTE: You need to manually install fonts for the time being by going to https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip
    "mpv/scripts/uosc".source = "${pkgs.mpvScripts.uosc}/share/mpv/scripts/uosc";
  };
}
