{

  # 2022-12-14 raehik: PipeWire seems best. fancy. needs some PulseAudio bits
  # though
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # 2022-12-14 raehik TODO not tested
    config.pipewire-pulse = {
      "context.exec" = [
        # among other stuff, gives nice "mute on unplug" behaviour
        { path = "pactl";
          args = "load-module module-switch-on-connect";
        }
      ];
    };

    #jack.enable = true;

  };

}
