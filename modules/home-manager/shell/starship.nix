{ config, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      right_format = "$cmd_duration";

      nix_shell = {
        impure_msg = "[impure](bold #${colors.base08})";
        pure_msg = "[pure](bold #${colors.base0B})";
        unknown_msg = "[unknown](bold #${colors.base0A})";
        format = "via [ $state( \\($name\\))](bold #${colors.base0D}) ";
      };

      git_status = {
        ahead = "󰶣";
        behind = "󰶡";
      };

      directory = {
        format = "[ ](bold #${colors.base0D})[ $path ]($style)";
        style = "bold #${colors.base07}";
      };

      character = {
        success_symbol = "[ ](bold #${colors.base0D})[ ➜](bold #${colors.base0B})";
        error_symbol = "[ ](bold #${colors.base0D})[ ➜](bold #${colors.base08})";
        vimcmd_symbol = "[ ](bold #${colors.base0D})[ ](bold #${colors.base0B})";
        vimcmd_replace_one_symbol = "[ ](bold #${colors.base0D})[ ](bold #${colors.base0E})";
        vimcmd_replace_symbol = "[ ](bold #${colors.base0D})[ ](bold #${colors.base0E})";
        vimcmd_visual_symbol = "[ ](bold #${colors.base0D})[ ](bold #${colors.base0A})";
      };

      cmd_duration = {
        format = "[]($style)[[󰔚 ](bg:#${colors.base01} fg:#${colors.base0A} bold)$duration](bg:#${colors.base01} fg:#${colors.base05})[ ]($style)";
        disabled = false;
        style = "bg:none fg:#${colors.base01}";
      };
    };
  };
}
