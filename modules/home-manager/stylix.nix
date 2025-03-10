{
  pkgs,
  config,
  lib,
  ...
}:
{

  stylix = {
    enable = true;

    targets = {
      rofi.enable = false;
      emacs.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      kde.enable = false;
      gnome.enable = false;
      kitty.variant256Colors = true;
      firefox = {
        firefoxGnomeTheme.enable = true;
        profileNames = [ "nox" ];
      };
    };

    fonts = {
      serif = config.stylix.fonts.sansSerif;

      sansSerif = {
        package = pkgs.google-fonts;
        name = "Readex Pro";
      };

      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "Caskaydia Cove NF";
      };

      emoji = {
        package = pkgs.apple-emoji;
        name = "Apple Color Emoji";
      };

      sizes.terminal = 14;
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = lib.mkDefault "Bibata-Modern-Ice";
      size = lib.mkDefault 24;
    };

    override = lib.mkDefault {
      base00 = "#000000";
      base01 = "#090909";
      base02 = "#181825";
    };

    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = lib.mkDefault "dark";
    image = ./wallpaper.jpg;
  };

  specialisation.light.configuration.stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
    polarity = "light";
    cursor.name = "Bibata-Modern-Classic";

    override = {
      base00 = "#FBF7F0";
      base01 = "#efe9dd";
      base02 = "#c9b9b0";
      #e8e3d7
    };
  };

  home.packages = [
    (lib.lowPrio (
      pkgs.writeShellApplication {
        name = "toggle-theme";
        runtimeInputs = with pkgs; [
          home-manager
          coreutils
          ripgrep
          dconf
          procps
        ];
        text = ''
          rm /home/nox/.config/hyprpanel/config.json
          "$(home-manager generations | head -1 | rg -o '/[^ ]*')"/specialisation/light/activate
          dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
          pkill -SIGUSR1 zsh
        '';
      }
    ))
  ];

  specialisation.light.configuration = {
    home.packages = [
      (pkgs.writeShellApplication {
        name = "toggle-theme";
        runtimeInputs = with pkgs; [
          home-manager
          coreutils
          ripgrep
          dconf
          procps
        ];
        text = ''
          rm /home/nox/.config/hyprpanel/config.json
          "$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate
          dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
          pkill -SIGUSR1 zsh
        '';
      })
    ];
  };
}
