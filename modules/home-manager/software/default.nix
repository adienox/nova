{ pkgs, inputs, ... }:
{
  imports = [
    ./anyrun
    ./swww.nix
    ./xremap.nix
    ./darkman.nix
    ./media
    ./valent.nix
    ./btop.nix
    ./waybar
    ./mako.nix
    ./rofi
  ];

  home.packages = with pkgs; [
    nautilus
    vesktop
    telegram-desktop
    qbittorrent-enhanced
    inputs.zen-browser.packages.${pkgs.system}.default
    calibre
    maestral
  ];

  services.blueman-applet.enable = true;
  services.mpris-proxy.enable = true;

  xdg.configFile."vesktop/themes/custom.css".text = ''
    @import url("https://mwittrien.github.io/BetterDiscordAddons/Themes/EmojiReplace/base/Apple.css"); /* Apple emoji */
  '';
}
