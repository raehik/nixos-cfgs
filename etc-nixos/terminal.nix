# "Physical" tty-related configuration.

{

  console = {
    font = "Lat2-Terminus16";
    # keyMap = "uk"; # broken??
    useXkbConfig = true; # use xkbOptions in tty.
  };

  services.xserver.xkbOptions = "caps:escape";

}
