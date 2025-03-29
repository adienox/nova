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
      "api/groq" = { };
      "api/perplexity" = { };
      "api/todoist" = { };
      "identity/mail" = { };
      "identity/url" = { };
      "identity/gpg" = { };
      "identity/gcal/id" = { };
      "identity/gcal/secret" = { };
      "identity/gdrive/id" = { };
      "identity/gdrive/secret" = { };
      "identity/gtasks/id" = { };
      "identity/gtasks/secret" = { };
      "identity/freshrss/url" = { };
      "identity/freshrss/pass" = { };
      "identity/wallabag/id" = { };
      "identity/wallabag/secret" = { };
      "identity/wallabag/user" = { };
      "identity/wallabag/pass" = { };
    };
  };
}
