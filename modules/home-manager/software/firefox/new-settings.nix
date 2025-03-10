{ ... }:
{
  # PREF: disable login manager
  "signon.rememberSignons" = false;

  # PREF: disable address and credit card manager
  "extensions.formautofill.addresses.enabled" = false;
  "extensions.formautofill.creditCards.enabled" = false;

  # PREF: enable HTTPS-Only Mode
  # Warn me before loading sites that don't support HTTPS
  # in both Normal and Private Browsing windows.
  "dom.security.https_only_mode" = true;
  "dom.security.https_only_mode_error_page_user_suggestions" = true;

  # PREF: set DoH provider
  # Hagezi Light + TIF
  "network.trr.uri" = "https://dns11.quad9.net/dns-query";

  # PREF: enforce DNS-over-HTTPS (DoH)
  "network.trr.mode" = 3;

  # Auto enable extensions to make it easier to install from nixos
  "extensions.autoDisableScopes" = 0;

  # Isolate cookies, you don't have to delete them every time, duh
  "privacy.firstparty.isolate" = true;

  # currently we set the same query stripping list that brave uses:
  # https://github.com/brave/brave-core/blob/f337a47cf84211807035581a9f609853752a32fb/browser/net/brave_site_hacks_network_delegate_helper.cc#L29
  "privacy.query_stripping.strip_list" =
    "__hsfp __hssc __hstc __s _hsenc _openstat dclid fbclid gbraid gclid hsCtaTracking igshid mc_eid ml_subscriber ml_subscriber_hash msclkid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id rb_clickid s_cid twclid vero_conv vero_id wbraid wickedid yclid";

  # useragent override
  "general.useragent.override" =
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";

  # PREF: delete all browsing data on shutdown
  "privacy.sanitize.sanitizeOnShutdown" = true;
  "privacy.clearOnShutdown_v2.cache" = true;
  "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
  "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;

  # PREF: after crashes or restarts= do not save extra session data
  # such as form content= scrollbar positions, and POST data
  "browser.sessionstore.privacy_level" = 2;

  # PREF: enable container tabs
  "privacy.userContext.enabled" = true;

  "gnomeTheme.bookmarksToolbarUnderTabs" = true;
}
