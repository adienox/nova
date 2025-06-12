{pkgs, ...}: let
  autolock-wasm = pkgs.fetchurl {
    url = "https://github.com/fresh2dev/zellij-autolock/releases/latest/download/zellij-autolock.wasm";
    hash = "sha256-aclWB7/ZfgddZ2KkT9vHA6gqPEkJ27vkOVLwIEh7jqQ=";
  };
in {
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij/plugins/zellij-autolock.wasm".source = autolock-wasm;
}
