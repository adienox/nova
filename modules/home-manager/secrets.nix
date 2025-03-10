{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  home.packages = with pkgs; [ sops ];

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.sops.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      "api/openai" = { };
      "api/gemini" = { };
      "api/perplexity" = { };
      "api/todoist" = { };
      "identity/mail" = { };
      "identity/gpg" = { };
      "identity/gcal/id" = { };
      "identity/gcal/secret" = { };
      "identity/gdrive/id" = { };
      "identity/gdrive/secret" = { };
      "identity/gtasks/id" = { };
      "identity/gtasks/secret" = { };
    };
  };
}
