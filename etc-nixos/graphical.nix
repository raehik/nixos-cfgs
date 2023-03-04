{ pkgs, ... }:

{

  # TODO 2023-03-03 Japanese IME. they all suck
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-mozc fcitx5-gtk];
  };

  # video (should be fairly global?)
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # 2022-12-14 raehik: endless issues with NVIDIA GTX 1080 unfree drivers (both
  # propriotary and open). so I think by not specifying, we should get free
  # (= nouveau/mesa)
  # needed a kernel param to disable GSP (NVreg_EnableGPU??)

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
