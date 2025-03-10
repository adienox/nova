{ ... }:
{
  # Auto enable extensions to make it easier to install from nixos
  "extensions.autoDisableScopes" = 0;

  # [CATEGORY] PRIVACY #

  # [SECTION] ISOLATION
  # default to strict mode, which includes:
  # 1. dFPI for both normal and private windows
  # 2. strict blocking lists for trackers
  # 3. shims to avoid breakage caused by blocking lists
  # 4. stricter policies for xorigin referrers
  # 5. dFPI specific cookie cleaning mechanism
  # 6. query stripping
  #
  # the desired category must be set with pref() otherwise it won't stick.
  # the UI that allows to change mode manually is hidden.
  "browser.contentblocking.category" = "strict";
  # enable APS
  "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
  "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = false;

  # [SECTION] SANITIZING
  # all the cleaning prefs true by default except for siteSetting and offlineApps,
  # which is what we want. users should set manual exceptions in the UI if there
  # are cookies they want to keep.
  "privacy.clearOnShutdown.offlineApps" = true;
  "privacy.sanitize.sanitizeOnShutdown" = true;
  "privacy.sanitize.timeSpan" = 0;

  # Isolate cookies, you don't have to delete them every time, duh
  "privacy.firstparty.isolate" = true;

  # [SECTION] CACHE AND STORAGE #
  "browser.cache.disk.enable" = false; # disable disk cache
  # prevent media cache from being written to disk in pb, but increase max cache size to avoid playback issues #
  "browser.privatebrowsing.forceMediaMemoryCache" = true;
  "media.memory_cache_max_size" = 65536;
  "browser.shell.shortcutFavicons" = false; # disable favicons in profile folder
  "browser.helperApps.deleteTempFileOnExit" = true; # delete temporary files opened with external apps

  # [SECTION] HISTORY AND SESSION RESTORE
  # since we hide the UI for modes other than custom we want to reset it for
  # everyone. same thing for always on PB mode.
  "privacy.history.custom" = true;
  "browser.privatebrowsing.autostart" = false;
  "browser.formfill.enable" = false; # disable form history
  "browser.sessionstore.privacy_level" = 2; # prevent websites from storing session data like cookies and forms

  # [SECTION] QUERY STRIPPING
  # currently we set the same query stripping list that brave uses:
  # https://github.com/brave/brave-core/blob/f337a47cf84211807035581a9f609853752a32fb/browser/net/brave_site_hacks_network_delegate_helper.cc#L29
  "privacy.query_stripping.strip_list" =
    "__hsfp __hssc __hstc __s _hsenc _openstat dclid fbclid gbraid gclid hsCtaTracking igshid mc_eid ml_subscriber ml_subscriber_hash msclkid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id rb_clickid s_cid twclid vero_conv vero_id wbraid wickedid yclid";
  #
  # librewolf specific pref that allows to include the query stripping lists in uBO by default.
  # the asset file is fetched every 7 days.
  # FIX: search
  #"librewolf.uBO.assetsBootstrapLocation" = "https://gitlab.com/librewolf-community/browser/source/-/raw/main/assets/uBOAssets.json";

  # [SECTION] LOGGING
  # these prefs are off by default in the official Mozilla builds,
  # so it only makes sense that we also disable them.
  # See https://gitlab.com/librewolf-community/settings/-/issues/240
  "browser.dom.window.dump.enabled" = false;
  "devtools.console.stdout.chrome" = false;

  # [CATEGORY] NETWORKING #

  # [SECTION] HTTPS #
  "dom.security.https_only_mode" = true; # only allow https in all windows, including private browsing
  "network.auth.subresource-http-auth-allow" = 1; # block HTTP authentication credential dialogs
  "general.useragent.override" =
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";

  # [SECTION] REFERERS
  # to enhance privacy but keep a certain level of usability we trim cross-origin
  # referers to only send scheme, host and port, instead of completely avoid sending them.
  # as a general rule, the behavior of referes which are not cross-origin should not
  # be changed.
  "network.http.referer.XOriginTrimmingPolicy" = 2;

  # [SECTION] WEBRTC
  # there is no point in disabling webrtc as mDNS protects the private IP on linux, osx and win10+.
  # the private IP address is only used in trusted environments, eg. allowed camera and mic access.
  "media.peerconnection.ice.default_address_only" = true; # use a single interface for ICE candidates, the vpn one when a vpn is used

  # [SECTION] PROXY #
  "network.gio.supported-protocols" = ""; # disable gio as it could bypass proxy
  "network.file.disable_unc_paths" = true; # hidden, disable using uniform naming convention to prevent proxy bypass
  "network.proxy.socks_remote_dns" = true; # forces dns query through the proxy when using one
  "media.peerconnection.ice.proxy_only_if_behind_proxy" = true; # force webrtc inside proxy when one is used

  # [SECTION] DNS #
  "network.dns.disablePrefetch" = true; # disable dns prefetching
  #
  # librewolf does not use DoH, but it can be enabled with the following prefs:
  "network.trr.mode" = 2;
  "network.trr.uri" = "https://dns.quad9.net/dns-query";

  # the possible modes are:
  # 0 = default
  # 1 = browser picks faster
  # 2 = DoH with system dns fallback
  # 3 = DoH without fallback
  # 5 = DoH is off, default currently

  # [SECTION] PREFETCHING AND SPECULATIVE CONNECTIONS
  # disable prefecthing for different things such as links, bookmarks and predictions.
  "network.predictor.enabled" = false;
  "network.prefetch-next" = false;
  "network.http.speculative-parallel-limit" = 0;
  "browser.places.speculativeConnect.enabled" = false;
  # disable speculative connections and domain guessing from the urlbar
  "browser.urlbar.speculativeConnect.enabled" = false;

  # [CATEGORY] FINGERPRINTING #

  # [SECTION] RFP
  # https://lukket.me/make-librewolf-request-dark-theme-on-websites/
  # taking inspiration from the above source
  "privacy.resistFingerprinting" = false;
  "privacy.fingerprintingProtection" = true;
  "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";

  # Canvas fingerprint protection
  "privacy.trackingprotection.cryptomining.enabled" = true;
  "privacy.trackingprotection.fingerprinting.enabled" = true;

  # increase the size of new RFP windows for better usability, while still using a rounded value.
  # if the screen resolution is lower it will stretch to the biggest possible rounded value.
  # also, expose hidden letterboxing pref but do not enable it for now.

  "privacy.window.maxInnerWidth" = 1600;
  "privacy.window.maxInnerHeight" = 900;
  "privacy.resistFingerprinting.letterboxing" = false;

  # [SECTION] WEBGL #
  "webgl.disabled" = false;

  # [CATEGORY] SECURITY #

  # [SECTION] CERTIFICATES #
  "security.cert_pinning.enforcement_level" = 2; # enable strict public key pinning, might cause issues with AVs
  #
  # enable safe negotiation and show warning when it is not supported. might cause breakage
  # if the the server does not support RFC 5746, in tha case SSL_ERROR_UNSAFE_NEGOTIATION
  # will be shown.
  #
  "security.ssl.require_safe_negotiation" = true;
  "security.ssl.treat_unsafe_negotiation_as_broken" = true;
  #
  # our strategy with revocation is to perform all possible checks with CRL, but when a cert
  # cannot be checked with it we use OCSP stapled with hard-fail, to still keep privacy and
  # increase security.
  # crlite is in mode 3 by default, which allows us to detect false positive with OCSP.
  # in v103, when crlite is fully mature, it will switch to mode 2 and no longer double-check.
  #
  "security.remote_settings.crlite_filters.enabled" = true;
  "security.OCSP.require" = true; # set to hard-fail, might cause SEC_ERROR_OCSP_SERVER_ERROR

  # [SECTION] TLS/SSL #
  "security.tls.enable_0rtt_data" = false; # disable 0 RTT to improve tls 1.3 security
  "security.tls.version.enable-deprecated" = false; # make TLS downgrades session only by enforcing it with pref(), default
  "browser.xul.error_pages.expert_bad_cert" = true; # show relevant and advanced issues on warnings and error screens

  # [SECTION] PERMISSIONS #
  "permissions.delegation.enabled" = false; # force permission request to show real origin
  "permissions.manager.defaultsUrl" = ""; # revoke special permissions for some mozilla domains

  # [SECTION] SAFE BROWSING
  # disable safe browsing, including the fetch of updates. reverting the 7 prefs below
  # allows to perform local checks and to fetch updated lists from google.
  "browser.safebrowsing.malware.enabled" = false;
  "browser.safebrowsing.phishing.enabled" = false;
  "browser.safebrowsing.blockedURIs.enabled" = false;
  "browser.safebrowsing.provider.google4.gethashURL" = "";
  "browser.safebrowsing.provider.google4.updateURL" = "";
  "browser.safebrowsing.provider.google.gethashURL" = "";
  "browser.safebrowsing.provider.google.updateURL" = "";

  # disable safe browsing checks on downloads, both local and remote. the resetting prefs
  # control remote checks, while the first one is for local checks only.

  "browser.safebrowsing.downloads.enabled" = false;
  "browser.safebrowsing.downloads.remote.enabled" = false;
  "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
  "browser.safebrowsing.downloads.remote.block_uncommon" = false;
  # empty for defense in depth
  "browser.safebrowsing.downloads.remote.url" = "";
  "browser.safebrowsing.provider.google4.dataSharingURL" = "";

  # [SECTION] OTHERS #
  "network.IDN_show_punycode" = true; # use punycode in idn to prevent spoofing
  "pdfjs.enableScripting" = false; # disable js scripting in the built-in pdf reader

  # [CATEGORY] REGION #

  # [SECTION] LOCATION
  # replace google with mozilla as the default geolocation provide and prevent use of OS location services
  "geo.provider.network.url" =
    "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
  "geo.provider.use_gpsd" = false; # [LINUX]
  "geo.provider.use_geoclue" = false; # [LINUX]

  # Disable geolocation
  "geo.enabled" = false;
  "geo.wifi.uri" = "";
  "browser.search.geoip.url" = "";
  "browser.search.geoSpecificDefaults" = false;
  "browser.search.geoSpecificDefaults.url" = "";
  "browser.search.modernConfig" = false;

  # [SECTION] LANGUAGE
  # show language as en-US for all users, regardless of their OS language and browser language.
  # both prefs must use pref() and not defaultPref to work.
  "javascript.use_us_english_locale" = true;
  "intl.accept_languages" = "en-US, en";

  # disable region specific updates from mozilla
  "browser.region.network.url" = "";
  "browser.region.update.enabled" = false;

  # [CATEGORY] BEHAVIOR #

  # [SECTION] DRM #
  "media.eme.enabled" = false; # master switch for drm content
  "media.gmp-manager.url" = "data:text/plain,"; # prevent checks for plugin updates when drm is disabled
  # disable the widevine and the openh264 plugins
  "media.gmp-provider.enabled" = false;
  "media.gmp-gmpopenh264.enabled" = false;

  # [SECTION] SEARCH AND URLBAR
  # disable search suggestion and do not update opensearch engines.
  "browser.urlbar.suggest.searches" = false;
  "browser.search.suggest.enabled" = false;
  "browser.search.update" = false;

  # the pref disables the whole feature and hide it from the ui
  # (as noted in https://bugzilla.mozilla.org/show_bug.cgi?id=1755057).
  # this also includes the best match feature, as it is part of firefox suggest.

  "browser.urlbar.quicksuggest.enabled" = false;
  "browser.urlbar.suggest.weather" = false; # disable weather suggestions in urlbar once they are no longer behind feature gate

  # [SECTION] DOWNLOADS
  # user interaction should always be required for downloads, as a way to enhance security by asking
  # the user to specific a certain save location.
  "browser.download.useDownloadDir" = false;
  "browser.download.autohideButton" = false; # do not hide download button automatically
  "browser.download.manager.addToRecentDocs" = false; # do not add downloads to recents
  "browser.download.alwaysOpenPanel" = false; # do not expand toolbar menu for every download, we already have enough interaction

  # [SECTION] AUTOPLAY
  # block autoplay unless element is right-clicked. this means background videos, videos in a different tab,
  # or media opened while other media is played will not start automatically.
  # thumbnails will not autoplay unless hovered. exceptions can be set from the UI.
  "media.autoplay.default" = 5;

  # [SECTION] POP-UPS AND WINDOWS
  # prevent scripts from resizing existing windows and opening new ones, by forcing them into
  # new tabs that can't be resized as well.
  "dom.disable_window_move_resize" = true;
  "browser.link.open_newwindow" = 3;
  "browser.link.open_newwindow.restriction" = 0;

  # [SECTION] MOUSE #
  "browser.tabs.searchclipboardfor.middleclick" = false; # prevent mouse middle click on new tab button to trigger searches or page loads

  # [CATEGORY] EXTENSIONS #

  # [SECTION] USER INSTALLED
  # extensions are allowed to operate on restricted domains, while their scope
  # is set to profile+applications (https://mike.kaply.com/2012/02/21/understanding-add-on-scopes/).
  # an installation prompt should always be displayed.
  "extensions.webextensions.restrictedDomains" = "";
  "extensions.enabledScopes" = 5; # hidden
  "extensions.postDownloadThirdPartyPrompt" = false;
  # Extensions cannot be updated without permission
  "extensions.update.enabled" = false;
  # Enable extensions by default in private mode
  "extensions.allowPrivateBrowsingByDefault" = true;

  # the pref disables quarantined domains.
  # this is a security feature, we should remove it with v116 as there will be a UI to control this per-extension.
  # unless we patch remote settings we rely on static dumps. this means even if we did not flip this pref it would
  # not make a difference at the moment.

  "extensions.quarantinedDomains.enabled" = false;

  # [SECTION] SYSTEM
  # built-in extension are not allowed to auto-update. additionally the reporter extension
  # of webcompat is disabled. urls are stripped for defense in depth.
  #
  "extensions.systemAddon.update.enabled" = false;
  "extensions.systemAddon.update.url" = "";
  "extensions.webcompat-reporter.enabled" = false;
  "extensions.webcompat-reporter.newIssueEndpoint" = "";

  # [SECTION] EXTENSION FIREWALL
  # the firewall can be enabled with the below prefs, but it is not a sane default:
  # "extensions.webextensions.base-content-security-policy" = "default-src 'none'; script-src 'none'; object-src 'none';";
  # "extensions.webextensions.base-content-security-policy.v3" = "default-src 'none'; script-src 'none'; object-src 'none';";

  # [CATEGORY] BUILT-IN FEATURES #

  # [SECTION] UPDATER
  # disable auto update
  "app.update.auto" = false;

  # [SECTION] SYNC
  # this pref fully controls the feature, including its ui.
  "identity.fxaccounts.enabled" = true;

  # [SECTION] LOCKWISE
  # disable the default password manager built into the browser, including its autofill
  # capabilities and formless login capture.
  "signon.rememberSignons" = false;
  "signon.autofillForms" = false;
  "extensions.formautofill.addresses.enabled" = false;
  "extensions.formautofill.creditCards.enabled" = false;
  "signon.formlessCapture.enabled" = false;

  # [SECTION] CONTAINERS
  # enable containers and show the settings to control them in the stock ui
  "privacy.userContext.enabled" = true;
  "privacy.userContext.ui.enabled" = true;

  # [SECTION] DEVTOOLS
  # enable remote debugging.
  "devtools.debugger.remote-enabled" = true; # default, but subject to branding so keep it
  "devtools.chrome.enabled" = true;
  "devtools.selfxss.count" = 0; # required for devtools console to work

  # [SECTION] OTHERS #
  "webchannel.allowObject.urlWhitelist" = ""; # remove web channel whitelist
  "services.settings.server" = "https://%.invalid"; # set the remote settings URL (REMOTE_SETTINGS_SERVER_URL in the code)

  # [CATEGORY] UI #

  # [SECTION] NICE TO HAVE
  "browser.toolbars.bookmarks.visibility" = "never";
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2,1.3,1.4,1.5";
  "browser.tabs.firefox-view" = false;
  # Disable alt key opening menu bar
  "ui.key.menuAccessKey" = 0;

  # Do not tell what plugins do we have enabled: https://mail.mozilla.org/pipermail/firefox-dev/2013-November/001186.html
  "plugins.enumerable_names" = "";
  "plugin.state.flash" = 0;

  # Disable sensors
  "dom.battery.enabled" = false;
  "device.sensors.enabled" = false;
  "camera.control.face_detection.enabled" = false;
  "camera.control.autofocus_moving_callback.enabled" = false;

  # Don't ping Mozilla for MitM detection, see <https://bugs.torproject.org/32321>
  "security.certerrors.mitm.priming.enabled" = false;
  "security.certerrors.recordEventTelemetry" = false;

  # Disable shield/heartbeat
  "extensions.shield-recipe-client.enabled" = false;
  "browser.selfsupport.url" = "";

  # No search suggestions
  "browser.urlbar.userMadeSearchSuggestionsChoice" = true;

  # Disable Pocket integration
  "browser.pocket.enabled" = false;
  "extensions.pocket.enabled" = false;

  # Avoid logjam attack
  "security.ssl3.dhe_rsa_aes_128_sha" = false;
  "security.ssl3.dhe_rsa_aes_256_sha" = false;
  "security.ssl3.dhe_dss_aes_128_sha" = false;
  "security.ssl3.dhe_rsa_des_ede3_sha" = false;
  "security.ssl3.rsa_des_ede3_sha" = false;

  # Crypto hardening
  # https://gist.github.com/haasn/69e19fc2fe0e25f3cff5
  # General settings
  "security.tls.unrestricted_rc4_fallback" = false;
  "security.tls.insecure_fallback_hosts.use_static_list" = false;
  "security.tls.version.min" = 1;
  "security.ssl3.rsa_seed_sha" = true;

  # Disable SSDP
  "browser.casting.enabled" = false;

  # Disable directory service
  "social.directories" = "";

  # Don't report TLS errors to Mozilla
  "security.ssl.errorReporting.enabled" = false;

  # Disable home snippets
  "browser.aboutHomeSnippets.updateUrl" = "data:text/html";

  # PFS url
  "pfs.datasource.url" = "http://127.0.0.1/";
  "pfs.filehint.url" = "http://127.0.0.1/";

  # Disable Link to FireFox Marketplace, currently loaded with non-free "apps"
  "browser.apps.URL" = "";

  # Disable Firefox Hello
  "loop.enabled" = false;

  # Services
  "gecko.handlerService.schemes.mailto.0.name" = "";
  "gecko.handlerService.schemes.mailto.1.name" = "";
  "handlerService.schemes.mailto.1.uriTemplate" = "";
  "gecko.handlerService.schemes.mailto.0.uriTemplate" = "";
  "browser.contentHandlers.types.0.title" = "";
  "browser.contentHandlers.types.0.uri" = "";
  "browser.contentHandlers.types.1.title" = "";
  "browser.contentHandlers.types.1.uri" = "";
  "gecko.handlerService.schemes.webcal.0.name" = "";
  "gecko.handlerService.schemes.webcal.0.uriTemplate" = "";
  "gecko.handlerService.schemes.irc.0.name" = "";
  "gecko.handlerService.schemes.irc.0.uriTemplate" = "";

  "font.default.x-western" = "sans-serif";

  "extensions.getAddons.langpacks.url" = "http://127.0.0.1/";
  "browser.xr.warning.infoURL" = "";

  # Disable onboarding
  "browser.onboarding.newtour" = "performance,private,addons,customize,default";
  "browser.onboarding.updatetour" = "performance,library,singlesearch,customize";
  "browser.onboarding.enabled" = false;

  # Disable screenshots extension
  "extensions.screenshots.disabled" = true;

  # New tab settings
  "browser.newtabpage.activity-stream.showTopSites" = false;
  "browser.newtabpage.activity-stream.feeds.snippets" = false;
  "browser.newtabpage.activity-stream.disableSnippets" = true;
  "browser.newtabpage.activity-stream.tippyTop.service.endpoint" = "";

  # Enable xrender
  "gfx.xrender.enabled" = true;

  # Disable push notifications
  "dom.webnotifications.enabled" = false;
  "dom.webnotifications.serviceworker.enabled" = false;
  "dom.push.enabled" = false;

  # Disable recommended extensions
  "browser.newtabpage.activity-stream.asrouter.useruser_prefs.cfr" = false;
  "extensions.htmlaboutaddons.discover.enabled" = false;

  # Disable use of WiFi region/location information
  "browser.region.network.scan" = false;

  # Disable VPN/mobile promos
  "browser.contentblocking.report.mobile-ios.url" = "";
  "browser.contentblocking.report.mobile-android.url" = "";
  "browser.contentblocking.report.vpn.url" = "";
  "browser.contentblocking.report.vpn-promo.url" = "";
  "browser.contentblocking.report.vpn-android.url" = "";
  "browser.contentblocking.report.vpn-ios.url" = "";
  "browser.privatebrowsing.promoEnabled" = false;

  # [SECTION] BRANDING
  # set librewolf support and releases urls in the UI, so that users land in the proper places.
  "app.support.baseURL" = "https://support.librewolf.net/";
  "browser.search.searchEnginesURL" = "https://librewolf.net/docs/faq/#how-do-i-add-a-search-engine";
  "browser.geolocation.warning.infoURL" =
    "https://librewolf.net/docs/faq/#how-do-i-enable-location-aware-browsing";
  "app.feedback.baseURL" = "https://librewolf.net/#questions";
  "app.releaseNotesURL" = "https://gitlab.com/librewolf-community/browser";
  "app.releaseNotesURL.aboutDialog" = "https://gitlab.com/librewolf-community/browser";
  "app.update.url.details" = "https://gitlab.com/librewolf-community/browser";
  "app.update.url.manual" = "https://gitlab.com/librewolf-community/browser";

  # [SECTION] FIRST LAUNCH
  # disable what's new and ui tour on first start and updates. the browser
  # should also not stress user about being the default one.
  "browser.startup.homepage_override.mstone" = "ignore";
  "startup.homepage_override_url" = "about:blank";
  "startup.homepage_welcome_url" = "about:blank";
  "startup.homepage_welcome_url.additional" = "";
  "browser.messaging-system.whatsNewPanel.enabled" = false;
  "browser.uitour.enabled" = false;
  "browser.uitour.url" = "";
  "browser.shell.checkDefaultBrowser" = false;
  # Prevent EULA dialog to popup on first run
  "browser.EULA.override" = true;

  # [SECTION] NEW TAB PAGE
  # we want NTP to display nothing but the search bar without anything distracting.
  # the three prefs below are just for minimalism and they should be easy to revert for users.
  "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
  "browser.newtabpage.activity-stream.section.highlights.includeVisited" = true;
  "browser.newtabpage.activity-stream.feeds.topsites" = false;
  # hide stories and sponsored content from Firefox Home
  "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
  "browser.newtabpage.activity-stream.showSponsored" = false;
  "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
  # disable telemetry in Firefox Home
  "browser.newtabpage.activity-stream.feeds.telemetry" = false;
  "browser.newtabpage.activity-stream.telemetry" = false;
  # hide stories UI in about:preferences#home, empty highlights list
  "browser.newtabpage.activity-stream.feeds.section.topstories.options" = ''{"hidden":true}'';
  "browser.newtabpage.activity-stream.default.sites" = "";

  # [SECTION] ABOUT
  # remove annoying ui elements from the about pages, including about:protections
  "browser.contentblocking.report.lockwise.enabled" = false;
  "browser.contentblocking.report.hide_vpn_banner" = true;
  "browser.contentblocking.report.vpn.enabled" = false;
  "browser.contentblocking.report.show_mobile_app" = false;
  "browser.vpn_promo.enabled" = false;
  "browser.promo.focus.enabled" = false;
  # ...about:addons recommendations sections and more
  "extensions.htmlaboutaddons.recommendations.enabled" = false;
  "extensions.getAddons.showPane" = false;
  "lightweightThemes.getMoreURL" = ""; # disable button to get more themes
  # ...about:preferences#home
  "browser.topsites.useRemoteSetting" = false; # hide sponsored shortcuts button
  # ...and about:config
  "browser.aboutConfig.showWarning" = false;
  # hide about:preferences#moreFromMozilla
  "browser.preferences.moreFromMozilla" = false;

  # [SECTION] RECOMMENDED
  # disable all "recommend as you browse" activity.
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;

  # [CATEGORY] TELEMETRY
  # telemetry is already disabled elsewhere and most of the stuff in here is just for redundancy.
  "toolkit.telemetry.unified" = false; # master switch
  "toolkit.telemetry.enabled" = false; # master switch
  "toolkit.telemetry.server" = "data:,";
  "toolkit.telemetry.archive.enabled" = false;
  "toolkit.telemetry.newProfilePing.enabled" = false;
  "toolkit.telemetry.updatePing.enabled" = false;
  "toolkit.telemetry.firstShutdownPing.enabled" = false;
  "toolkit.telemetry.shutdownPingSender.enabled" = false;
  "toolkit.telemetry.bhrPing.enabled" = false;
  "toolkit.telemetry.cachedClientID" = "";
  "toolkit.telemetry.previousBuildID" = "";
  "toolkit.telemetry.server_owner" = "";
  "toolkit.coverage.opt-out" = true; # hidden
  "toolkit.telemetry.coverage.opt-out" = true; # hidden
  "toolkit.coverage.enabled" = false;
  "toolkit.coverage.endpoint.base" = "";
  "toolkit.crashreporter.infoURL" = "";
  "datareporting.healthreport.uploadEnabled" = false;
  "datareporting.policy.dataSubmissionEnabled" = false;
  "security.protectionspopup.recordEventTelemetry" = false;
  "browser.ping-centre.telemetry" = false;
  # opt-out of normandy and studies
  "app.normandy.enabled" = false;
  "app.normandy.api_url" = "";
  "app.shield.optoutstudies.enabled" = false;
  # disable personalized extension recommendations
  "browser.discovery.enabled" = false;
  # disable crash report
  "browser.tabs.crashReporting.sendReport" = false;
  "breakpad.reportURL" = "";
  # disable connectivity checks
  "network.connectivity-service.enabled" = false;
  # disable captive portal
  "network.captive-portal-service.enabled" = false;
  "captivedetect.canonicalURL" = "";

  # smooth scrolling
  # based on natural smooth scrolling v2 by aveyo
  "apz.allow_zooming" = true; # true
  "apz.force_disable_desktop_zooming_scrollbars" = false; # false
  "apz.paint_skipping.enabled" = true; # true
  "apz.windows.use_direct_manipulation" = true; # true
  "dom.event.wheel-deltaMode-lines.always-disabled" = true; # false
  "general.smoothScroll.currentVelocityWeighting" = "0.12"; # "0.25" <- 1. If scroll too slow, set to "0.15"
  "general.smoothScroll.durationToIntervalRatio" = 1000; # 200
  "general.smoothScroll.lines.durationMaxMS" = 100; # 150
  "general.smoothScroll.lines.durationMinMS" = 0; # 150
  "general.smoothScroll.mouseWheel.durationMaxMS" = 100; # 200
  "general.smoothScroll.mouseWheel.durationMinMS" = 0; # 50
  "general.smoothScroll.mouseWheel.migrationPercent" = 100; # 100
  "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12; # 120
  "general.smoothScroll.msdPhysics.enabled" = true; # false
  "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 200; # 1250
  "general.smoothScroll.msdPhysics.regularSpringConstant" = 200; # 1000
  "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 10; # 12
  "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = "1.20"; # "1.3"
  "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 1000; # 2000
  "general.smoothScroll.other.durationMaxMS" = 100; # 150
  "general.smoothScroll.other.durationMinMS" = 0; # 150
  "general.smoothScroll.pages.durationMaxMS" = 100; # 150
  "general.smoothScroll.pages.durationMinMS" = 0; # 150
  "general.smoothScroll.pixels.durationMaxMS" = 100; # 150
  "general.smoothScroll.pixels.durationMinMS" = 0; # 150
  "general.smoothScroll.scrollbars.durationMaxMS" = 100; # 150
  "general.smoothScroll.scrollbars.durationMinMS" = 0; # 150
  "general.smoothScroll.stopDecelerationWeighting" = "0.6"; # "0.4"
  "layers.async-pan-zoom.enabled" = true; # true
  "layout.css.scroll-behavior.spring-constant" = "250.0"; # "250.0"
  "mousewheel.acceleration.factor" = 3; # 10
  "mousewheel.acceleration.start" = -1; # -1
  "mousewheel.default.delta_multiplier_x" = 100; # 100
  "mousewheel.default.delta_multiplier_y" = 100; # 100
  "mousewheel.default.delta_multiplier_z" = 100; # 100
  "mousewheel.min_line_scroll_amount" = 0; # 5
  "mousewheel.system_scroll_override.enabled" = true; # true <- 2. If scroll too fast, set to false
  "mousewheel.system_scroll_override_on_root_content.enabled" = false; # true
  "mousewheel.transaction.timeout" = 1500; # 1500
  "toolkit.scrollbox.horizontalScrollDistance" = 4; # 5
  "toolkit.scrollbox.verticalScrollDistance" = 3; # 3

  "layout.css.color-mix.enabled" = true;
  "layout.css.light-dark.enabled" = true;
  "layout.css.has-selector.enabled" = true;

  # lepton
  "userChrome.icon.panel_full" = true;
  "userChrome.padding.panel" = false;
  "userChrome.centered.urlbar" = true;
  "userChrome.centered.bookmarkbar" = true;
  "userChrome.padding.urlbar" = false;
  "browser.tabs.cardPreview.enabled" = false;

  # fastfox.js

  # PREF: notification interval (in microseconds) to avoid layout thrashing
  # When Firefox is loading a page, it periodically reformats or "reflows" the page as it loads. The page displays new elements every 0.12 seconds by default. These redraws increase the total page load time.
  # The default value provides good incremental display of content without causing an increase in page load time.
  # [NOTE] Lowering the interval will increase responsiveness but also increase the total load time.
  # [WARNING] If this value is set below 1/10 of a second, it starts to impact page load performance.
  # [EXAMPLE] 100000 = .10s = 100 reflows/second
  # [1] https://searchfox.org/mozilla-central/rev/c1180ea13e73eb985a49b15c0d90e977a1aa919c/modules/libpref/init/StaticPrefList.yaml#1824-1834
  # [2] https://dev.opera.com/articles/efficient-javascript/?page=3#reflow
  # [3] https://dev.opera.com/articles/efficient-javascript/?page=3#smoothspeed
  "content.notify.interval" = 100000; # (.10s); default=120000 (.12s)

  # PREF: GPU-accelerated Canvas2D
  # Use gpu-canvas instead of to skia-canvas.
  # [WARNING] May cause issues on some Windows machines using integrated GPUs [2] [3]
  # Add to your overrides if you have a dedicated GPU.
  # [NOTE] Higher values will use more memory.
  # [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1741501
  # [2] https://github.com/yokoffing/Betterfox/issues/153
  # [3] https://github.com/yokoffing/Betterfox/issues/198
  #user_pref("gfx.canvas.accelerated", true); // DEFAULT macOS LINUX [FF110]; not compatible with WINDOWS integrated GPUs
  "gfx.canvas.accelerated.cache-items" = 4096; # default=2048; alt=8192
  "gfx.canvas.accelerated.cache-size" = 512; # default=256; alt=1024
  "gfx.content.skia-font-cache-size" = 20; # default=5; Chrome=20
  # [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1239151#c2

  # PREF: compression level for cached JavaScript bytecode [FF102+]
  # [1] https://github.com/yokoffing/Betterfox/issues/247
  # 0 = do not compress (default)
  # 1 = minimal compression
  # 9 = maximal compression
  "browser.cache.jsbc_compression_level" = 3;

  # PREF: adjust video buffering periods when not using MSE (in seconds)
  # [NOTE] Does not affect videos over 720p since they use DASH playback [1]
  # [1] https://lifehacker.com/preload-entire-youtube-videos-by-disabling-dash-playbac-1186454034
  "media.cache_readahead_limit" = 7200; # 120 min; default=60; stop reading ahead when our buffered data is this many seconds ahead of the current playback
  "media.cache_resume_threshold" = 3600; # 60 min; default=30; when a network connection is suspended, don't resume it until the amount of buffered data falls below this threshold

  # PREF: image cache
  #"image.cache.size", 5242880); // DEFAULT; in MiB; alt=10485760 (cache images up to 10MiB in size)
  "image.mem.decode_bytes_at_a_time" = 32768; # default=16384; alt=65536; chunk size for calls to the image decoders

  # PREF: increase the absolute number of HTTP connections
  # [1] https://kb.mozillazine.org/Network.http.max-connections
  # [2] https://kb.mozillazine.org/Network.http.max-persistent-connections-per-server
  # [3] https://www.reddit.com/r/firefox/comments/11m2yuh/how_do_i_make_firefox_use_more_of_my_900_megabit/jbfmru6/
  "network.http.max-connections" = 1800; # default=900
  "network.http.max-persistent-connections-per-server" = 10; # default=6; download connections; anything above 10 is excessive
  "network.http.max-urgent-start-excessive-connections-per-host" = 5; # default=3
  "network.http.max-persistent-connections-per-proxy" = 48; # default=32
  #"network.websocket.max-connections"= 200; // DEFAULT

  # PREF: pacing requests [FF23+]
  # Controls how many HTTP requests are sent at a time.
  # Pacing HTTP requests can have some benefits= such as reducing network congestion,
  # improving web page loading speed= and avoiding server overload.
  # Pacing requests adds a slight delay between requests to throttle them.
  # If you have a fast machine and internet connection= disabling pacing
  # may provide a small speed boost when loading pages with lots of requests.
  # false=Firefox will send as many requests as possible without pacing
  # true=Firefox will pace requests (default
  "network.http.pacing.requests.enabled" = false;
  "network.http.pacing.requests.min-parallelism" = 10; # default=6
  "network.http.pacing.requests.burst" = 14; # default=10

  # PREF: increase DNS cache
  # [1] https://developer.mozilla.org/en-US/docs/Web/Performance/Understanding_latency
  "network.dnsCacheEntries" = 1000; # default=400

  # PREF: adjust DNS expiration time
  # [ABOUT] about:networking#dns
  # [NOTE] These prefs will be ignored by DNS resolver if using DoH/TRR.
  "network.dnsCacheExpiration" = 3600; # keep entries for 1 hour
  #"network.dnsCacheExpirationGracePeriod"= 240; // default=60; cache DNS entries for 4 minutes after they expire

  # PREF: increase TLS token caching
  "network.ssl_tokens_cache_capacity" = 10240; # default=2048; more TLS token caching (fast reconnects)

  # PREF: DNS prefetching <link rel="dns-prefetch">
  # Used for cross-origin connections to provide small performance improvements.
  # Disable DNS prefetching to prevent Firefox from proactively resolving
  # hostnames for other domains linked on a page. This may eliminate
  # unnecessary DNS lookups= but can increase latency when following external links.
  # [1] https://bitsup.blogspot.com/2008/11/dns-prefetching-for-firefox.html
  # [2] https://css-tricks.com/prefetching-preloading-prebrowsing/#dns-prefetching
  # [3] https://www.keycdn.com/blog/resource-hints#2-dns-prefetching
  # [4] http://www.mecs-press.org/ijieeb/ijieeb-v7-n5/IJIEEB-V7-N5-2.pdf
  # [5] https://bugzilla.mozilla.org/show_bug.cgi?id=1596935
  "network.dns.disablePrefetchFromHTTPS" = true; # (FF127+ false)

  # PREF: CSS Masonry Layout [NIGHTLY]
  # [1] https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout/Masonry_Layout
  "layout.css.grid-template-masonry-value.enabled" = true;

  # PREF: Prioritized Task Scheduling API [NIGHTLY]
  # [1] https://blog.mozilla.org/performance/2022/06/02/prioritized-task-scheduling-api-is-prototyped-in-nightly/
  # [2] https://medium.com/airbnb-engineering/building-a-faster-web-experience-with-the-posttask-scheduler-276b83454e91
  "dom.enable_web_task_scheduling" = true;

  # PREF: HTML Sanitizer API [NIGHTLY]
  # [1] https://developer.mozilla.org/en-US/docs/Web/API/Sanitizer
  # [2] https://caniuse.com/mdn-api_sanitizer
  "dom.security.sanitizer.enabled" = true;

  "gnomeTheme.oledBlack" = true;
}
