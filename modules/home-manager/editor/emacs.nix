{
  pkgs,
  ...
}:
{
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
    hunspellDicts.en_US-large
    vips
    ffmpegthumbnailer
    nodePackages.prettier

    # python stuff
    python313Packages.flake8
    python313Packages.python-lsp-server

    # c stuff
    clang-tools

    # nix stuff
    nixfmt-rfc-style
    statix
    nixd

    # web stuff
    vscode-langservers-extracted

    # bash stuff
    bash-language-server

    # go stuff
    go

    (makeDesktopItem {
      name = "org-protocol";
      exec = "emacsclient %u";
      comment = "Org protocol";
      desktopName = "org-protocol";
      type = "Application";
      mimeTypes = [ "x-scheme-handler/org-protocol" ];
    })
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages =
      epkgs: with epkgs; [
        pdf-tools
        org-pdftools
        org-gcal
        mu4e
        nov
        djvu
        jinx
      ];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    startWithUserSession = "graphical";
  };
}
