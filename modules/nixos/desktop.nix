{ pkgs, ... }:
{
  i18n.defaultLocale = "en_US.UTF-8";

  environment.variables = {
    #https://unix.stackexchange.com/a/657578
    LIBSEAT_BACKEND = "logind";
  };

  # hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.XDG_SESSION_TYPE = "wayland";

  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;

    # make HM-managed GTK stuff work
    dconf.enable = true;
    seahorse.enable = true;
  };

  services = {
    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';
    libinput.enable = true;
    xserver = {
      # Required for DE to launch.
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };
  # unlock gnome keyring on login
  security.pam.services.gdm-password.enableGnomeKeyring = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nerd-fonts.symbols-only # in case when not using monospace nerd font
      font-awesome
      google-fonts
      apple-emoji
    ];
    fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" ];
  };
}
