{ pkgs, ... }:
{
  imports = [
    ./mpv.nix
    ./hw-volume.nix
    ./rnnoise.nix
  ];
  home.packages = with pkgs; [
    pwvucontrol
    helvum
  ];
}
