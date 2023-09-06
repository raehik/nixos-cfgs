# User configuration.

let

  user = {
    name = "raehik";
    uid  = 8239;
  };

in {

  users.users.${user.name} = {
    uid = user.uid;
    extraGroups = [ "wheel" "audio" "networkmanager" ];
    # TODO need to be in networkmanager group for non-sudo net stuff. ugly...
    isNormalUser = true;
  };

  nix.settings.trusted-users = [ user.name ];

}
