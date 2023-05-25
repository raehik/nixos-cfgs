# raehik's NixOS system configurations
I don't know much about Nix yet. This is my initial barebones system
configuration wrapped into a flake. home-manager exists, but isn't used very
much.

## Deleting old generations
```
sudo nix-collect-garbage -d
sudo nixos-rebuild boot --flake .
```

`nixos-rebuild` figure out `/boot`. It's stupid and annoying, sorry.
