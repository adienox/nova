{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;

    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        shell
        symbols
        translate
        rink
      ];

      width.fraction = 0.3;
      y.fraction = 0.3;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = builtins.readFile ./style.css;
    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          desktop_actions: true,
          max_entries: 5,
        )
      '';

      "symbols.run".text = ''
        Config(
          symbols: {
            "cc": "🥺",
            "hh": "❤️",
            "hm": "🏡",
            "la": "😂",
            "kk": "😘",
            "mm": "😩",
          },
          max_entries: 3,
        )
      '';

      "shell.ron".text = ''
        Config(
          prefix: ">"
        )
      '';
    };
  };
}
