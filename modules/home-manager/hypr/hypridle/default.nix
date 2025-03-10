{ pkgs, ... }:
let
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";

  brightness-fade = pkgs.writeShellApplication {
    name = "brightness-fade";
    runtimeInputs = with pkgs; [
      coreutils
      brightnessctl
      bash
    ];
    text = builtins.readFile ./fade.sh;
  };

  suspend-script = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.playerctl}/bin/playerctl metadata -f "{{status}}" | ${pkgs.ripgrep}/bin/rg "Playing"
    # only suspend if audio isn't running and no other user is logged in
    if [ $? == 1 ] && [ "$(who | ${pkgs.ripgrep}/bin/rg tty | wc -l)" -eq 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = hyprlock;
        lock_cmd = hyprlock;
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "${brightness-fade}/bin/brightness-fade fade";
          on-resume = "${brightness-fade}/bin/brightness-fade resume";
        }
        {
          timeout = 500;
          on-timeout = hyprlock;
        }
        {
          timeout = 600;
          on-timeout = "${suspend-script}";
        }
      ];
    };
  };
}
