final: prev: {
  win11-icon-theme = prev.callPackage ./win11-icon-theme.nix { };
  apple-emoji = prev.callPackage ./fonts/apple-emoji.nix { };
  rec-mono-nyx = prev.callPackage ./fonts/rec-mono-nyx.nix { };
}
