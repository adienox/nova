{
  pkgs,
  inputs,
  default,
  ...
}:
let
  youtube-icon = pkgs.fetchurl {
    url = "https://www.youtube.com/s/desktop/dbf5c200/img/favicon_144x144.png";
    hash = "sha256-lQ5gbLyoWCH7cgoYcy+WlFDjHGbxwB8Xz0G7AZnr9vI=";
  };
  brave-icon = pkgs.fetchurl {
    url = "https://brave.com/static-assets/images/brave-logo-sans-text.svg";
    hash = "sha256-JTD4D98hRLYvlpU6gcaYjJwxpsx8necuBpB5SFgXy+c=";
  };
  github-icon = pkgs.fetchurl {
    url = "https://github.githubassets.com/favicons/favicon.png";
    hash = "sha256-dM+QrC/mYkqxBWys6hHPftT4vvVLuw6GljgBO7pFvAg=";
  };
  ffpkgs = inputs.firefox-addons.packages.${pkgs.system};
in
{
  imports = [ inputs.betterfox.homeManagerModules.betterfox ];
  programs.firefox = {
    enable = true;
    policies = {
      Cookies = {
        Allow = [
          "https://chatgpt.com"
          "https://accounts.google.com"
          "https://readwise.io"
          "https://read.readwise.io"
          "https://account.proton.me"
          "https://www.youtube.com"
          "https://github.com"
          "https://monkeytype.com"
          "https://search.brave.com"
          "https://www.cineby.app"
        ];
      };
      NoDefaultBookmarks = true;
      ExtensionSettings = {
        # catppuccin github file explorer icons
        "{bbb880ce-43c9-47ae-b746-c3e0096c5b76}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-gh-file-explorer/latest.xpi";
          installation_mode = "force_installed";
        };
        # imagus
        "{00000f2a-7cde-4f20-83ed-434fcb420d71}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/imagus/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    betterfox.enable = true;

    profiles.nox = {
      search = {
        default = "Brave";
        force = true;
      };
      userChrome = ''
        ${builtins.readFile ./userChrome.css}
        ${builtins.readFile ./customizations.css}
      '';
      userContent = builtins.readFile ./userContent.css;
      betterfox = {
        enable = true;
        enableAllSections = true;
      };

      search.engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "np" ];
        };

        "Github Repos" = {
          urls = [
            {
              template = "https://github.com/search";
              params = [
                {
                  name = "type";
                  value = "repositories";
                }
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = github-icon;
          definedAliases = [ "gh" ];
        };

        "Youtube" = {
          urls = [
            {
              template = "https://www.youtube.com/results";
              params = [
                {
                  name = "search_query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = youtube-icon;
          definedAliases = [ "yt" ];
        };

        "Brave" = {
          urls = [
            {
              template = "https://search.brave.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = brave-icon;
          definedAliases = [ "bb" ];
        };

        "Bing".metaData.hidden = true;
        "DuckDuckGo".metaData.hidden = true;
        "Amazon.com".metaData.hidden = true;
        "Wikipedia (en)".metaData.alias = "wk";
        "Google".metaData.alias = "gg";
      };

      extensions = with ffpkgs; [
        sponsorblock
        ublock-origin
        darkreader
        facebook-container
        search-by-image
        stylus
        clearurls
        don-t-fuck-with-paste
        vimium
        skip-redirect
        bitwarden
        simple-tab-groups
        #languagetool
      ];

      settings = import ./new-settings.nix { inherit default; };
    };
  };
}
