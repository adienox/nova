{ config, ... }:
{
  services.xremap = {
    serviceMode = "user";
    userName = config.user.name;
    withHypr = true;
    watch = true;
    # Modmap for single key rebinds
    config = {
      modmap = [
        {
          name = "Global";
          remap = {
            "CapsLock" = {
              held = "leftctrl";
              alone = "esc";
              alone_timeout_millis = 350;
            };
            "CONTROL_L" = {
              held = "leftctrl";
              alone = "esc";
              alone_timeout_millis = 350;
            };
          };
        }
      ];
      keymap = [
        {
          name = "browser";
          application = {
            only = "firefox";
          };
          remap = {
            "C-j" = "down";
            "C-k" = "up";
          };
        }
      ];
    };
  };
}
