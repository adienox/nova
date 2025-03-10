{ pkgs, ... }:
{
  services.darkman = {
    enable = true;
    darkModeScripts = {
      toggle = "toggle-theme";
    };
    lightModeScripts = {
      toggle = "toggle-theme";
    };
  };

  systemd.user.services = {
    darkman-light = {
      Unit.Description = "Set Darkman to light mode";
      Service = {
        ExecStart = "${pkgs.darkman}/bin/darkman set light";
        Type = "oneshot";
      };
    };
    darkman-dark = {
      Unit.Description = "Set Darkman to dark mode";
      Service = {
        ExecStart = "${pkgs.darkman}/bin/darkman set dark";
        Type = "oneshot";
      };
    };
  };

  systemd.user.timers = {
    darkman-light = {
      Unit.Description = "Timer to set Darkman to light mode";
      Install.WantedBy = [ "timers.target" ];
      Timer = {
        OnCalendar = "*-*-* 6:00:00";
        Persistent = true;
      };
    };
    darkman-dark = {
      Unit.Description = "Timer to set Darkman to dark mode";
      Install.WantedBy = [ "timers.target" ];
      Timer = {
        OnCalendar = "*-*-* 17:30:00";
        Persistent = true;
      };
    };
  };
}
