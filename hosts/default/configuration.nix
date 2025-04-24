{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/amd.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/security.nix
    ../../modules/nixos/software.nix
    ../../modules/nixos/power-management.nix
    ../../modules/nixos/user.nix
    ../../modules/nixos/bluetooth.nix
  ];

  time.timeZone = "Asia/Kathmandu";
  networking.hostName = "anomaly";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # loading of a kernel module is done by using modprobe
  # listing loaded kernel modules is done by lsmod
  boot.extraModulePackages = [config.boot.kernelPackages.ddcci-driver];

  # here i2c-8 device name is found by trying all the devices in the path
  # using ddcutil getvcp 10 -b * where * is the device id
  #FIXME: make the following code run after booting to enable backlight control of monitor
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.kmod}/bin/modprobe ddcci_backlight
    echo 'ddcci 0x37' | tee /sys/bus/i2c/devices/i2c-8/new_device
  '';

  user.enable = true;
  user.name = "nox";
  user.description = "Adienox";

  system.stateVersion = "24.11";
}
