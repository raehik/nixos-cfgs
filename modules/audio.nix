{ pkgs, ... }:

{

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    config.pipewire-pulse = {
      "context.exec" = [
        # among other stuff, gives nice "mute on unplug" behaviour
        { path = "pactl";
          args = "load-module module-switch-on-connect";
        }
      ];
    };

  };

  environment.systemPackages = with pkgs; [
    pulseaudio # needed for pactl, which I use with PipeWire
  ];

}
