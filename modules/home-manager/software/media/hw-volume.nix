{...}: {
  # systemctl --user restart wireplumber.service pipewire.service
  xdg.configFile = {
    "wireplumber/wireplumber.conf.d/80-bluez-properties.conf" = {
      source = ./80-bluez-properties.conf;
    };
    "wireplumber/wireplumber.conf.d/51-set-priorities.conf" = {
      source = ./51-set-priorities.conf;
    };
  };
}
