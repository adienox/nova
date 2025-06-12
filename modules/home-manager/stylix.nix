{
  pkgs,
  config,
  lib,
  ...
}: let
  shellPkgs = with pkgs; [
    home-manager
    coreutils
    ripgrep
    dconf
    procps
  ];
in {
  stylix = {
    enable = true;

    targets = {
      rofi.enable = false;
      emacs.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      kde.enable = false;
      gnome.enable = false;
      waybar.enable = false;
      qt.enable = true;
      kitty.variant256Colors = true;
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

      sizes = {
        terminal = 14;
        popups = 12;
      };
    };

    opacity = {
      terminal = lib.mkDefault 0.7;
      popups = 0.7;
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
      size = 24;
    };

    override = lib.mkDefault {
      base00 = "#000000";
      base01 = "#090909";
      base02 = "#181825";
    };

    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = lib.mkDefault "dark";
    # just setting this to make stylix work
    image = config.lib.stylix.pixel "base00";
  };

  specialisation.light.configuration.stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
    polarity = "light";
    cursor.name = "Bibata-Modern-Classic";

    opacity.terminal = 0.5;

    override = {
      base00 = "#FBF7F0";
      base01 = "#efe9dd";
      base02 = "#c9b9b0";
    };
  };

  home.packages = [
    (lib.lowPrio (
      pkgs.writeShellApplication {
        name = "toggle-theme";
        runtimeInputs = shellPkgs;
        text = ''
          "$(home-manager generations | head -1 | rg -o '/[^ ]*')"/specialisation/light/activate
          dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
          touch ~/.config/zellij/config.kdl
          pkill -SIGUSR1 zsh
        '';
      }
    ))
  ];

  specialisation.light.configuration = {
    home.packages = [
      (pkgs.writeShellApplication {
        name = "toggle-theme";
        runtimeInputs = shellPkgs;
        text = ''
          "$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate
          dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
          touch ~/.config/zellij/config.kdl
          pkill -SIGUSR1 zsh
        '';
      })
    ];
  };
}
