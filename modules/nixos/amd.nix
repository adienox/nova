{ lib, ... }:
{
  config = {
    services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];

    hardware.graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;
    };

    hardware.amdgpu.initrd.enable = lib.mkDefault true;
  };
}
