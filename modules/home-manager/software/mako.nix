{
  config,
  lib,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors;
in {
  home.packages = with pkgs; [libnotify];

  services.mako = {
    enable = true;
    sort = "+time";
    margin = "10,10,0";
    padding = "10";
    borderSize = 2;
    borderRadius = 6;
    defaultTimeout = 10000;
    groupBy = "body";
    borderColor = lib.mkForce colors.withHashtag.base0E;
  };
}
