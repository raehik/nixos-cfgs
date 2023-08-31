# Common locale-related settings that raehik uses.
# Generally means British English keyboard, EN+JA locales, London timezone.

{ ... }:

{

  # keyboard layout
  console.useXkbConfig = true;
  services.xserver.layout = "gb";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      # "ja_JP.SJIS/SJIS" # 2022-12-14 raehik: not supported!
      "C.UTF-8/UTF-8" # 2023-01-11 raehik: idk, apparently important
    ];
  };

  time.timeZone = "Europe/London";

}
