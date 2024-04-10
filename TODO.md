* can we somehow use `inputs` in NixOS modules? could help clean up some messy
  imports. see shymega's NixOS cfg
* home-manager module needs to take user as arg
* Look at linux-zen. Worth? Maybe make a module.
* Never used nix-ld, but may need in future: https://github.com/Mic92/nix-ld
* I use imports and modules really poorly, lots of relative imports. Error
  reporting is trash when an import borks. Awful developer UX.
* BUG: 2024-03-01: Wine doesn't like multimon. Not NixOS fault.
  https://github.com/swaywm/sway/wiki#mouse-events-clicking-scrolling-arent-working-on-some-of-my-workspaces
