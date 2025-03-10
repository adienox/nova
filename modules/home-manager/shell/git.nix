{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Adienox";
    userEmail = "adwait@adhk.dev";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
    ignores = [
      ".env"
      "*~"
      "*.swp"
    ];
  };
}
