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

  fonts = {

    # 2025-05-08: uh, this seems to replace tons of my base CJK fonts...
    # probably because I don't set defaults. which is complicated. urgh
    /*
    fontconfig.localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        <!-- fall back to Kochi Mincho for MS Mincho -->
        <alias>
          <family>ＭＳ 明朝</family>
          <accept>
            <family>Kochi Mincho</family>
          </accept>
        </alias>
        <!-- fall back to Kochi Gothic for MS Gothic -->
        <alias>
          <family>ＭＳ ゴシック</family>
          <accept>
            <family>Kochi Gothic</family>
          </accept>
        </alias>
      </fontconfig>
    '';
    */

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      hack-font
      fira-code
      font-awesome # TODO 2022-12-14 specifically for i3status-rs...
      roboto
      #kochi-substitute # MS Mincho replacement; TODO should be module sw/ja/font
    ];

  };

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
