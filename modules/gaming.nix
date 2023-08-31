{
  programs.steam.enable = true;

  # to help Steam find Proton-GE
  environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";

}
