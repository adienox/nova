{
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "apple-emoji";
  version = "17.4";

  src = fetchurl {
    url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/v${version}/AppleColorEmoji.ttf";
    sha256 = "sha256-SG3JQLybhY/fMX+XqmB/BKhQSBB0N1VRqa+H6laVUPE=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/usr/share/fonts/TTF
    cp $src $out/usr/share/fonts/TTF/
  '';
}
