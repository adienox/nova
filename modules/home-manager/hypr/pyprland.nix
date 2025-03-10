{ inputs, pkgs, ... }:
let
  pyprland = inputs.pyprland.packages.${pkgs.system}.pyprland;
in
{
  home.packages = [ pyprland ];

  systemd.user.services = {
    pyprland = {
      Unit = {
        Description = "Scratchpads and more";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pyprland}/bin/pypr";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
