{pkgs, ...}: let
  json = pkgs.formats.json {};

  hw-volume-enable = {
    monitor.bluez.properties = {
      bluez5.enable-hw-volume = true;
    };
  };
in {
  # systemctl --user restart wireplumber.service pipewire.service
  xdg.configFile."wireplumber/wireplumber.conf.d/80-bluez-properties.conf" = {
    source = json.generate "80-bluez-properties.conf" hw-volume-enable;
  };
}
