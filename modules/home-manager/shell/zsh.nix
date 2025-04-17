{ pkgs, lib, ... }:
let
  lsd = "${pkgs.lsd}/bin/lsd";
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";
    dirHashes = {
      docs = "$HOME/Documents";
      vids = "$HOME/Videos";
      dl = "$HOME/Downloads";
    };

    historySubstringSearch.enable = true;
    history = {
      extended = true;
      ignoreAllDups = true;
      ignorePatterns = [
        "rm *"
        "pkill *"
      ];
      path = "$ZDOTDIR/.zsh_history";
      save = 1000000;
      size = 1000000;
    };

    shellAliases = {
      e = "emacsclient";
      rm = "${pkgs.trash-cli}/bin/trash";
      ls = lsd;
      ll = "${lsd} -l";
      dc = "docker compose";
    };

    completionInit = ''
      zstyle ":completion:*:*:*:*:*" menu select
      zstyle ":completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"
      _comp_options+=(globdots)
    '';
    initExtra = ''
      # Plugins
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

      source $ZDOTDIR/theming
      # Resource theming when zsh recieves USR1 signal
      trap 'source $ZDOTDIR/theming' USR1
    '';
  };
  xdg.configFile."zsh/theming".text = lib.mkDefault ''
    export LS_COLORS=$(${pkgs.vivid}/bin/vivid generate catppuccin-mocha)
  '';
  specialisation.light.configuration = {
    xdg.configFile."zsh/theming".text = ''
      export LS_COLORS=$(${pkgs.vivid}/bin/vivid generate catppuccin-latte)
    '';
  };
}
