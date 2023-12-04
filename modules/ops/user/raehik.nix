{

  users.users."raehik" = {
    uid = 8239;
    extraGroups = [ "wheel" "audio" "networkmanager" ];
    # TODO need to be in networkmanager group for non-sudo net stuff. ugly...
    isNormalUser = true;
  };

  nix.settings.trusted-users = [ "raehik" ];

}
