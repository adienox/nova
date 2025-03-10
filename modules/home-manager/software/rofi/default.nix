{
  pkgs,
  default,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    #cliphist # Clipboard History
    pinentry-gnome3
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "Readex Pro 16";
    plugins = with pkgs; [
      rofi-emoji-wayland
      rofi-calc
    ];

    theme = (
      config.lib.stylix.colors {
        template = builtins.readFile ./theme.rasi.mustache;
        extension = "rasi";
      }
    );
    extraConfig = {
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      window-format = "	{t:0}";
      sidebar-mode = true;
      display-drun = "Applications  ";
      display-window = "Tasks  ";
      display-emoji = "Emoji  ";
      display-calc = "Calc 󰃬";
      show-match = false;
      modi = "drun,window";

      # Keybindings
      kb-remove-to-eol = "";
      kb-mode-complete = "";
      kb-row-left = "Control+h";
      kb-row-right = "Control+l";
      kb-row-down = "Control+j,Control+n,Down";
      kb-row-up = "Control+k,Control+p,Up";
      kb-mode-previous = "Control+Alt+h,Control+Shift+Tab";
      kb-mode-next = "Control+Alt+l,Control+Tab";
      kb-remove-char-back = "BackSpace,Shift+BackSpace";
      kb-accept-entry = "Return,KP_Enter";
      kb-remove-word-back = "Control+BackSpace";
    };
  };

}
