{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ swww ];

  systemd.user.services = {
    swww = {
      Unit = {
        Description = "Wayland wallpaper daemon";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        ExecStartPost = "${pkgs.swww}/bin/swww img ${config.xdg.cacheHome}/background";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
