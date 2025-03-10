{ pkgs, ... }:

{

  # TODO 2024-08-08 Japanese IME. they all suck
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [fcitx5-mozc fcitx5-gtk];
  };

  # autostart IME on Sway etc. see: https://nixos.wiki/wiki/Fcitx5
  # 2024-08-08: doesn't seem to work. lol. oh well idc just run manually
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    hack-font
    fira-code
    font-awesome # TODO 2022-12-14 specifically for i3status-rs...
    roboto
  ];

  # xdg desktop integration for screen sharing
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
    };
  };

  # swaylock needs some stuff, this does it
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # TODO ? wat dis
  };

}
