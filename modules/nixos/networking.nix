{ ... }:
{
  networking = {
    networkmanager.enable = true;

    nameservers = [
      "94.140.14.14"
      "94.140.15.15"
      "1.1.1.1"
    ];
    networkmanager.insertNameservers = [
      "94.140.14.14"
      "94.140.15.15"
      "1.1.1.1"
    ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        8080 # calibre
        9090 # calibre
        8765 # anki
      ];
      allowedUDPPorts = [
        8765 #anki
      ];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ]; # Needed for KDE connect
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ]; # Needed for KDE connect
    };
  };
}
