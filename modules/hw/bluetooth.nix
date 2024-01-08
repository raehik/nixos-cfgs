# Enable Bluetooth support.
# Should also work with dongles, so not really a hardware-level module.
{
  hardware.bluetooth.enable = true;
  services.blueman.enable = true; # GUI Bluetooth manager
}
