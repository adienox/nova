{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    user.enable = lib.mkEnableOption "enable user module";
    user.name = lib.mkOption {
      default = "nox";
      description = "username";
    };
    user.description = lib.mkOption {
      default = "Adienox";
      description = "description";
    };
  };
  config = lib.mkIf config.user.enable {
    users.users.${config.user.name} = {
      isNormalUser = true;
      description = config.user.description;
      extraGroups = [
        "vboxusers"
        "networkmanager"
        "wheel"
        "video"
        "audio"
        "adbusers"
        "input"
        "docker"
        "wireshark"
        "i2c"
      ];
      shell = pkgs.zsh;
    };
  };
}
