{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    cmake
    gnumake
    gcc
    ripgrep
    fd
    libtool
    texliveFull
    gdrive3
    pandoc
    emacsclient-commands
    vips
    ffmpegthumbnailer
    nodePackages.prettier
    yt-dlp
    # spellcheck
    (aspellWithDicts (dicts: with dicts; [en en-computers en-science]))
    # email
    mu
    isync
    protonmail-bridge
    # calendar
    khal
    vdirsyncer
    # lookup
    ripgrep
    wordnet
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        vterm
        mu4e
        pdf-tools
      ];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    startWithUserSession = "graphical";
  };

  systemd.user = {
    services = {
      protonmail-bridge = {
        Unit = {
          Description = "Protonmail Bridge";
          PartOf = ["default.target"];
          After = ["network-online.target"];
          Wants = ["network-online.target"];
        };
        Service = {
          ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge -n";
          Restart = "on-failure";
        };
        Install.WantedBy = ["default.target"];
      };
      maestral-notes = {
        Unit = {
          Description = "Sync notes to dropbox";
          PartOf = ["default.target"];
          After = ["network-online.target"];
          Wants = ["network-online.target"];
        };
        Service = {
          ExecStart = "${pkgs.maestral}/bin/maestral start --config-name='notes'";
          Restart = "on-failure";
        };
        Install.WantedBy = ["default.target"];
      };
      vdirsyncer-sync = {
        Unit = {
          Description = "Sync Calenders";
          After = ["network-online.target"];
          Wants = ["network-online.target"];
        };
        Service = {
          ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer sync";
          Type = "oneshot";
        };
      };
    };
    timers = {
      vdirsyncer-sync = {
        Unit.Description = "Timer to start vdirsyncer sync";
        Install.WantedBy = ["timers.target"];
        Timer = {
          OnBootSec = "5min";
          OnUnitActiveSec = "11min";
        };
      };
    };
    paths = {
      vdirsyncer-sync = {
        Unit.Description = "Path change to start vdirsyncer sync";
        Install.WantedBy = ["default.target"];
        Path = {
          PathChanged = "${config.home.homeDirectory}/Documents/calendars/personal";
        };
      };
    };
  };
}
