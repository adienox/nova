{
  config,
  pkgs,
  ...
}: {
  # To import history from zsh
  # export HISTFILE && atuin import auto
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      update_check = false;
      keymap_mode = "vim-normal";
      enter_accept = true;
      sync_records = true;
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";
      show_help = false;
      show_tabs = false;
      inline_height = 20;
      daemon.enabled = true;
      history_filter = [
        "^cd"
        "^z "
        "^ls"
        "^mv"
        "^cp"
        "^y$"
        "^cls"
        "^clear"
        "^rm"
        "^source"
      ];
    };
  };
  systemd.user.services = {
    atuin = {
      Unit = {
        Description = "Atuin daemon";
        PartOf = ["default.target"];
        After = ["network.target"];
      };
      Service = {
        ExecStartPre = "${pkgs.coreutils}/bin/rm -f  ${config.xdg.dataHome}/atuin/atuin.sock";
        ExecStart = "${pkgs.atuin}/bin/atuin daemon";
        Restart = "on-failure";
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
