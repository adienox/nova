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
        1337
        22000 # syncthing
        2222 # sftp
        4040
        5050
        8080 # calibre
        9090 # calibre
        5040
      ];
      allowedUDPPorts = [
        1337
        8080
        2222
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
