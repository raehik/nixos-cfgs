{ pkgs, ... }:

{

  # TODO 2023-03-03 Japanese IME. they all suck
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-mozc fcitx5-gtk];
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
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
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
	xdg-desktop-portal-gtk
      ];
      #gtkUsePortal = true; # 2022-12-13 raehik: deprecated
    };
  };

  # swaylock needs some stuff, this does it
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # TODO ? wat dis
  };

}
