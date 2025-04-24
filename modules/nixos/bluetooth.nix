{...}: {
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
      Enable = "Source,Sink,Media,Socket";
    };
  };
}
