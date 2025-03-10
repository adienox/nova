{ pkgs, inputs, ... }:
{
  imports = [
    ./languagetool.nix
    ./services.nix
  ];
  environment.systemPackages = with pkgs; [
    wirelesstools
    psmisc
    wget
    seatd
    xdg-utils
    pciutils
    usbutils
    powertop
    polkit_gnome
    libcamera
    docker-compose
    neovim
    git
    ntfs3g
    ddcutil
    firefox
  ];

  programs = {
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    adb.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      settings = {
        max-cache-ttl = 86400;
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      shellInit = ''
        export ZDOTDIR="$HOME"/.config/zsh
      '';
    };
  };

  environment = {
    shells = with pkgs; [
      zsh
    ];

    # enable zsh autocompletion for system packages (systemd, etc)
    pathsToLink = [ "/share/zsh" ];

    # setting the ~/.local/bin to be in path for every user
    localBinInPath = true;
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # settings for xremap to work
  hardware.uinput.enable = true;

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    package = pkgs.nixVersions.latest;
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      substituters = [
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
}
