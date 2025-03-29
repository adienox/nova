{
  pkgs,
  config,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
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
      # ---------- General setting ----------
      modi = "drun,filebrowser,window,calc,emoji";
      case-sensitive = false;
      cycle = true;
      filter = "";
      scroll-method = 0;
      normalize-match = true;
      show-icons = true;
      icon-theme = "Papirus";
      steal-focus = false;

      # ---------- Matching setting ----------
      matching = "normal";
      tokenize = true;

      # ---------- SSH settings ----------
      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      parse-hosts = true;
      parse-known-hosts = true;

      # ---------- Drun settings ----------
      drun-categories = "";
      drun-match-fields = "name,generic,exec,categories,keywords";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      drun-show-actions = false;
      drun-url-launcher = "xdg-open";
      drun-use-desktop-cache = false;
      drun-reload-desktop-cache = false;

      # ---------- Run settings ----------
      run-command = "{cmd}";
      run-list-command = "";
      run-shell-command = "{terminal} -e {cmd}";

      # ---------- Window switcher settings ----------
      window-match-fields = "title,class";
      window-format = "{w} - {c} - {t:0}";
      window-thumbnail = false;

      # ---------- History and Sorting ----------
      disable-history = false;
      sorting-method = "normal";
      max-history-size = 25;

      # ---------- Display setting ----------
      display-window = "Windows";
      display-windowcd = "Window CD";
      display-run = "Run";
      display-ssh = "SSH";
      display-drun = "Apps";
      display-combi = "Combi";
      display-keys = "Keys";
      display-filebrowser = "Files";

      # ---------- Misc setting ----------
      terminal = "kitty";
      font = "Mono 12";
      sort = false;
      threads = 0;
      click-to-exit = true;

      # Keybindings
      kb-remove-to-eol = "";
      kb-mode-complete = "";
      kb-row-left = "Control+h";
      kb-row-right = "Control+l";
      kb-row-down = "Control+j,Control+n,Down";
      kb-row-up = "Control+k,Control+p,Up";
      kb-mode-previous = "Control+Alt+k,Control+Shift+Tab";
      kb-mode-next = "Control+Alt+j,Control+Tab";
      kb-remove-char-back = "BackSpace,Shift+BackSpace";
      kb-accept-entry = "Return,KP_Enter";
      kb-remove-word-back = "Control+BackSpace";
    };
  };
}
