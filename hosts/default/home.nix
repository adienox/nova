{...}: {
  imports = [
    ../../modules/home-manager
  ];

  home.username = "nox";
  home.homeDirectory = "/home/nox";

  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "emacsclient";
  };

  programs.home-manager.enable = true;
}
