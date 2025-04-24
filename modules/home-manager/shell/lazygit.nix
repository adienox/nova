{...}: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        border = "single";
        nerdFontsVersion = "3";
        showPanelJumps = false;
        showBottomLine = false;
      };
    };
  };
}
