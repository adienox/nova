{pkgs, ...}: {
  home.packages = [pkgs.valent];

  systemd.user.services.valent = {
    Unit = {
      Description = "GTK KdeConnect";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.valent}/bin/valent --gapplication-service";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
