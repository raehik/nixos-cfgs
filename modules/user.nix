# User configuration.

let

  user = {
    name = "raehik";
    uid  = 8239;
  };

in {

  users.users.${user.name} = {
    uid = user.uid;
    extraGroups = [ "wheel" "audio" ];
    isNormalUser = true;
  };

}
