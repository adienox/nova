{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    codespell
    tree-sitter
    nodejs-slim
    ripgrep
    gcc
    gnumake
    fzf
  ];
}
