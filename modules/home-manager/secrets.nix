{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  home.packages = with pkgs; [sops];

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.sops.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      "api/openai" = {};
      "api/gemini" = {};
      "api/perplexity" = {};
      "identity/gcal/id" = {};
      "identity/gcal/secret" = {};
      "identity/gcal/mail" = {};
      "identity/freshrss/url" = {};
      "identity/freshrss/pass" = {};
      "identity/wallabag/id" = {};
      "identity/wallabag/secret" = {};
      "identity/wallabag/user" = {};
      "identity/wallabag/pass" = {};
      "identity/protonmail-bridge/pass" = {};
    };
  };
}
