{inputs, ...}: {
  imports = [inputs.xremap.homeManagerModules.default];

  services.xremap = {
    withHypr = true;
    watch = true;
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
    };
  };
}
