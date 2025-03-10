{ pkgs, inputs, ... }:
{
  imports = [
    ./swww.nix
    ./xremap.nix
    ./darkman.nix
    ./rofi
    ./media
    ./valent.nix
    ./btop.nix
  ];
  home.packages = with pkgs; [
    nautilus
    vesktop
    telegram-desktop
    qbittorrent-enhanced
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
  xdg.configFile."vesktop/themes/custom.css".text = ''
    @import url("https://mwittrien.github.io/BetterDiscordAddons/Themes/EmojiReplace/base/Apple.css"); /* Apple emoji */
  '';
}
