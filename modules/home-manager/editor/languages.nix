{pkgs, ...}: {
  home.packages = with pkgs; [
    # python stuff
    python313Packages.flake8
    python313Packages.python-lsp-server
    python313Packages.ipython

    # c stuff
    clang-tools

    # shell stuff
    shfmt

    # nix stuff
    alejandra
    nixd

    # web stuff
    vscode-langservers-extracted
    prettierd

    # bash stuff
    bash-language-server

    # go stuff
    go

    # lua stuff
    luajitPackages.lua-lsp
    stylua
    lua-language-server

    # rust stuff
    cargo
    rustc
    rust-analyzer
    rustfmt

    yamlfmt
  ];
}
