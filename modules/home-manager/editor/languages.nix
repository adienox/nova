{pkgs, ...}: {
  home.packages = with pkgs; [
    # python stuff
    python313Packages.flake8
    python313Packages.python-lsp-server
    python313Packages.ipython

    # c stuff
    clang-tools

    # nix stuff
    nixfmt-rfc-style
    alejandra
    statix
    nixd

    # web stuff
    vscode-langservers-extracted

    # bash stuff
    bash-language-server

    # go stuff
    go

    # lua stuff
    luajitPackages.lua-lsp
    stylua

    # rust stuff
    cargo
    rustc
    rust-analyzer
    rustfmt

    tree-sitter
    lua-language-server
    nodejs-slim
    yamlfmt
  ];
}
