{ pkgs, config, ... }:
{
  imports = [
    ./atuin.nix
    ./kitty.nix
    ./starship.nix
    ./xdg.nix
    ./zsh.nix
    ./nix-index-db.nix
    ./carapace.nix
    ./zoxide.nix
    ./direnv.nix
    ./git.nix
    ./lsd.nix
  ];

  home.packages = with pkgs; [
    trash-cli
    imv
    mediainfo
    imagemagick
    p7zip
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nova";

    XDG_SESSION_TYPE = "wayland";

    # Reducing direnv logs
    DIRENV_LOG_FORMAT = "";

    # ~/ Clean-up:
    XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

    ANDROID_SDK_HOME = "${config.xdg.configHome}/android";
    ANSIBLE_CONFIG = "${config.xdg.configHome}/ansible/ansible.cfg";
    MBSYNCRC = "${config.xdg.configHome}/mbsync/config";
    PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc";
    IPYTHONDIR = "${config.xdg.configHome}/ipython";

    ELECTRUMDIR = "${config.xdg.dataHome}/electrum";
    UNISON = "${config.xdg.dataHome}/unison";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    GOPATH = "${config.xdg.dataHome}/go";
    SQLITE_HISTORY = "${config.xdg.dataHome}/sqlite_history";

    GOMODCACHE = "${config.xdg.cacheHome}/go/mod";

    NIXPKGS_ALLOW_UNFREE = 1;
    _ZO_EXCLUDE_DIRS = "/nix/*:/sys/*:/run/*";
  };
}
