{
  pkgs,
  stdenvNoCC,
  fetchFromGitHub,
  unstableGitUpdater,
}:
stdenvNoCC.mkDerivation rec {
  pname = "nu_scripts";
  version = "2024-08-13";

  src = fetchFromGitHub {
    owner = "nushell";
    repo = pname;
    rev = "1b5584a71d3b1143f7398688bc46b98c0756d6e1";
    hash = "sha256-eVPWCfQdleV+bVoGQMS6tNVFHHexakj9M6cO4/w1p8g=";
  };
  patches = [./colors.patch];
  propagatedBuildInputs = with pkgs; [
    atuin
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/nu_scripts
    mv ./* $out/share/nu_scripts

    atuin gen-completions --shell nushell > completions.nu
    mkdir $out/share/nu_scripts/custom-completions/atuin
    mv ./completions.nu $out/share/nu_scripts/custom-completions/atuin/atuin-completions.nu

    runHook postInstall
  '';

  passthru.updateScript = unstableGitUpdater {};
}
