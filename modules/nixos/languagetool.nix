{pkgs, ...}: {
  # https://gist.github.com/CRTified/9d996a6a7c548ca42fa3672eee95da92
  services.languagetool = {
    enable = true;
    allowOrigin = ""; # To allow access from browser addons

    settings = {
      # Optional, remove unneeded files
      # Data from:
      # https://languagetool.org/download/ngram-data/
      languageModel = pkgs.linkFarm "languageModel" {
        en = pkgs.fetchzip {
          # 15GB
          url = "https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip";
          hash = "sha256-v3Ym6CBJftQCY5FuY6s5ziFvHKAyYD3fTHr99i6N8sE=";
        };
      };

      fasttextBinary = "${pkgs.fasttext}/bin/fasttext";
      # Optional, but highly recommended
      # Data from:
      # https://fasttext.cc/docs/en/language-identification.html
      # 131 MB
      fasttextModel = pkgs.fetchurl {
        name = "lid.176.bin";
        url = "https://dl.fbaipublicfiles.com/fasttext/supervised-models/lid.176.bin";
        hash = "sha256-fmnsVFG8JhzHhE5J5HkqhdfwnAZ4nsgA/EpErsNidk4=";
      };
    };
  };
}
