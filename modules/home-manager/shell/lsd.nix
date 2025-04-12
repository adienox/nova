{ ... }:
{
  programs.lsd = {
    enable = true;
    settings = {
      date = "+%d %b %Y";
      ignore-globs = [
        ".nix-profile"
        ".nix-defexpr"
        ".zshenv"
        ".pki"
        ".devenv"
        ".direnv"
        ".ssh"
        ".local"
        ".cache"
      ];
      display = "almost-all";
      size = "short";
      sorting.dir-grouping = "first";
      blocks = [
        "permission"
        "user"
        "size"
        "date"
        "name"
      ];
    };
    colors = {
      user = "yellow";
      group = 187;
      tree-edge = 245;
      permission = {
        read = "yellow";
        write = "red";
        exec = "green";
        exec-sticky = 5;
        no-access = 245;
        octal = 6;
        acl = "dark_cyan";
        context = "cyan";
      };
      date = {
        hour-old = "blue";
        day-old = "blue";
        older = "dark_blue";
      };
      size = {
        none = 245;
        small = "green";
        medium = "yellow";
        large = "red";
      };
      inode = {
        valid = 13;
        invalid = 245;
      };
      links = {
        valid = 13;
        invalid = 245;
      };
      git-status = {
        default = 245;
        unmodified = 245;
        ignored = 245;
        new-in-index = "green";
        new-in-workdir = "green";
        typechange = "yellow";
        deleted = "red";
        renamed = "green";
        modified = "yellow";
        conflicted = "red";
      };
    };
  };

  xdg.configFile."lsd/icons.yaml".text = ''
    filetype:
      dir: 
    name:
      .envrc: 󰒓
    extension:
      nix: 
      gpg: 󰦝
      md : 󰍔
  '';
}
