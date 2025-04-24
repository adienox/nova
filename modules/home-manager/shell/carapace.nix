{pkgs, ...}: {
  home.packages = [pkgs.carapace];

  programs.zsh.completionInit = ''
    export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
    zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
    source <(carapace _carapace)
    zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
  '';
}
